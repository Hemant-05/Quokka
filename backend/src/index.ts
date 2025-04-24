import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import http from 'http';
import { Server } from 'socket.io';
import jwt from 'jsonwebtoken';
import authRoutes from './routes/auth.routes';
import postRoutes from './routes/post.routes';
import userRoutes from './routes/user.routes';
import chatRoutes from './routes/chat.routes';
import { prisma } from './prisma/client';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;
const server = http.createServer(app);

app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes);
app.use('/api/posts', postRoutes);
app.use('/api/users', userRoutes);
app.use('/api/chats/', chatRoutes);

const io = new Server(server, {
    cors: {
        origin: '*', // restrict this to frontend domain in production
        methods: ['GET', 'POST']
    }
});

io.use((socket, next) => {
    const token = socket.handshake.auth.token;
    try {
        const user = jwt.verify(token, process.env.JWT_SECRET!);
        socket.data.userId = user.userId;
        next();
    } catch (err) {
        next(new Error("Authentication error"));
    }
});

io.on('connection', (socket) => {
    const userId = socket.data.userId;
    console.log(`✅ User connected: ${userId}`);

    socket.on('joinRoom', (roomId) => {
        socket.join(roomId); // for chatId
    });

    socket.on('sendMessage', async ({ chatId, content }) => {
        // Save to DB using Prisma
        const newMessage = await prisma.message.create({
            data: {
                content,
                chatId,
                senderId: userId,
            },
            include: {
                sender: true,
            }
        });

        io.to(chatId).emit('receiveMessage', newMessage); // Send to all clients in that room
    });

    socket.on('disconnect', () => {
        console.log(`❌ User disconnected: ${userId}`);
    });
});

app.get('/', (req, res) => {
    return res.send('API is running');
});

app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));

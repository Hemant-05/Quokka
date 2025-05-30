import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import http from 'http';
import { Server } from 'socket.io';
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
    origin: '*', // Allow all for development. Restrict in production.
  },
});

io.on('connection', (socket) => {
  console.log(`User connected: ${socket.id}`);

socket.on('send-message', async (data) => {
    const {
      senderId,       // UUID of sender (user)
      chatId,         // ID of chat room (Chat table)
      content,        // Text content of message (optional)
      imageUrl,       // Optional image
      videoUrl        // Optional video
    } = data;

    try {
      const savedMessage = await prisma.message.create({
        data: {
          senderId,
          chatId,
          content,
          imageUrl,
          videoUrl,
        },
        include: {
          sender: true, // Optional: to send full sender info back
        }
      });

      // Emit to all users in the room
      io.to(chatId).emit('receive-message', savedMessage);

    } catch (error) {
      console.error("Error saving message:", error);
    }
  });


  socket.on('join-chat', (chatId) => {
    socket.join(chatId);
  });
  socket.on('leave-chat', (chatId) => {
    socket.leave(chatId);
  });

  socket.on('disconnect', () => {
    console.log(`User disconnected: ${socket.id}`);
  });
});

server.listen(PORT, () => {
  console.log('Socket.IO server running on http://localhost:${PORT}');
});


app.get('/', (req, res) => {
    return res.send('API is running');
});

app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));

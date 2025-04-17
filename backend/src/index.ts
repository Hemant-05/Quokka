import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import authRoutes from './routes/auth.routes';
import postRoutes from './routes/post.routes';


dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes);
app.use('/api/posts',postRoutes);

app.get('/', (req, res) => {
    return res.send('API is running');
});

app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));

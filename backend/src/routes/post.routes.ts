import express from 'express';
import {
  createPost,
  getAllPosts,
  deletePost,
  likePost,
  addComment,
} from '../controllers/post.controller';
import { isAuth } from '../middlewares/isAuth';

const router = express.Router();

router.post('/', isAuth, createPost);
router.get('/', getAllPosts);
// router.delete('/:id', isAuth, deletePost);
router.post('/like/:id', isAuth, likePost);
router.post('/comment/:id', isAuth, addComment);

export default router;

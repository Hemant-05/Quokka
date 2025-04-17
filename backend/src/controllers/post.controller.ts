import { Request, Response } from 'express';
import { prisma } from '../prisma/client';

export const createPost = async (req: Request, res: Response) => {
  try {
  const { content, imageUrl } = req.body;
  
  if (!req.userId) {
    return res.status(401).json({ message: "Unauthorized by hemant" });
  }
    const userId = req.userId;
    const post = await prisma.post.create({
      data: { content, imageUrl, authorId: userId! },
    } );
    res.status(201).json(post);
  } catch (err) {
    res.status(500).json({ message: "Error creating post", error: err.message });
  }
};

export const getAllPosts = async (_req: Request, res: Response) => {
  const posts = await prisma.post.findMany({
    include: {
      author: true,
      comments: true,
      likes: true,
    },
    orderBy: { createdAt: 'desc' },
  });
  res.json(posts);
};

export const deletePost = async (req: Request, res: Response) => {
  const { postId } = req.params;
  const userId = req.userId;

  const post = await prisma.post.findUnique({ where: { id: postId } });
  if (!post || post.authorId !== userId) {
    return res.status(403).json({ message: "Unauthorized" });
  }

  await prisma.post.delete({ where: { id: postId } });
  res.json({ message: "Post deleted" });
};

export const likePost = async (req: Request, res: Response) => {
  const { postId } = req.params;
  const userId = req.userId!;

  try {
    await prisma.like.create({
      data: { userId, postId },
    });
    res.json({ message: "Post liked" });
  } catch {
    res.status(400).json({ message: "Already liked" });
  }
};

export const unlikePost = async (req: Request, res: Response) => {
  const { postId } = req.params;
  const userId = req.userId!;

  await prisma.like.deleteMany({
    where: { postId, userId },
  });
  res.json({ message: "Post unliked" });
};

export const addComment = async (req: Request, res: Response) => {
  const { postId } = req.params;
  const { text } = req.body;
  const userId = req.userId!;

  const comment = await prisma.comment.create({
    data: { text, postId, userId },
  });

  res.status(201).json(comment);
};

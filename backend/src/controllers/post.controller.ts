import { Request, Response } from 'express';
import { prisma } from '../prisma/client';
import { Prisma } from '@prisma/client';

export const createPost = async (req: Request, res: Response) => {
  try {
    const { content, imageUrl } = req.body;
    if (!req.userId) {
      return res.status(401).json({ message: "Unauthorized by Server" });
    }
    const userId = req.userId;
    const post = await prisma.post.create({
      data: { content, imageUrl, authorId: userId! },
    });
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
  const { id: postId } = req.params;
  const userId = req.userId!;

  try {
    // Optional: Verify that the user is the owner of the post
    const post = await prisma.post.findUnique({ where: { id: postId } });

    if (!post) {
      return res.status(404).json({ message: "Post not found" });
    }

    if (post.authorId !== userId) {
      return res.status(403).json({ message: "Unauthorized to delete this post" });
    }

    // Delete the post
    await prisma.post.delete({
      where: { id: postId },
    });

    res.json({ message: "Post deleted successfully" });
  } catch (error: any) {
    res.status(500).json({ message: "Something went wrong", error: error.message });
  }
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
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2002') {
      return res.status(400).json({ message: "Post already liked by this user" });
    }

    res.status(500).json({ message: "Something went wrong", error: err.message });
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
  const { id: postId } = req.params; // post ID from URL
  const { content } = req.body; // comment text
  const userId = req.userId!;

  if (!content || content.trim() === "") {
    return res.status(400).json({ message: "Comment content is required" });
  }

  try {
    const comment = await prisma.comment.create({
      data: {
        content,
        postId,
        userId: userId,
      },
    });

    res.status(201).json({ message: "Comment added", comment });
  } catch (err) {
    res.status(500).json({ message: "Something went wrong", error: err.message });
  }
};

export const getPostComments = async (req: Request, res: Response) => {
  const { id: postId } = req.params;
  try {
    const comments = await prisma.comment.findMany({
      where: { postId },
      include: {
        user: {
          select: {
            id: true,
            username: true,
            email: true,
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });
    res.json(comments);
  } catch (err) { 
    res.status(500).json({message : "Error while fetching comments !!",error : err.message});
  }
};
import { Request, Response } from 'express';
import { prisma } from '../prisma/client';

export const followUser = async (req: Request, res: Response) => {
  const userId = req.userId!;
  const { targetUserId } = req.params;

  if (userId === targetUserId) {
    return res.status(400).json({ message: "You can't follow yourself" });
  }

  try {
    // Check if follow already exists
    const existingFollow = await prisma.follow.findFirst({
      where: {
        followerId: userId,
        followingId: targetUserId
      }
    });

    if (existingFollow) {
      return res.status(400).json({ message: 'You already follow this user' });
    }

    await prisma.follow.create({
      data: {
        follower: { connect: { id: userId } },
        following: { connect: { id: targetUserId } },
      },
    });

    res.json({ message: 'User followed successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong', error });
  }
};


export const unfollowUser = async (req: Request, res: Response) => {
  const userId = req.userId!;
  const { targetUserId } = req.params;

  try {
    const followRecord = await prisma.follow.findFirst({
      where: {
        followerId: userId,
        followingId: targetUserId
      }
    });

    if (!followRecord) {
      return res.status(404).json({ message: "You're not following this user" });
    }

    await prisma.follow.delete({
      where: { id: followRecord.id }
    });

    res.json({ message: 'User unfollowed successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong', error });
  }
};



// Get list of followers
export const getFollowers = async (req: Request, res: Response) => {
  const { userId } = req.params;

  try {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: {
        followers: {
          select: {
            id: true,
            follower: true,
            followerId: true,
          }
        }
      }
    });

    res.json({ followers: user?.followers });
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch followers', error });
  }
};

// Get list of following
export const getFollowing = async (req: Request, res: Response) => {
  const { userId } = req.params;

  try {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: {
        following: {
          select: {
            id: true,
            following: true,
            followingId: true,
          }
        }
      }
    });

    res.json({ following: user?.following });
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch following', error });
  }
};

// get list of all users
export const getAllUsers = async (req: Request, res: Response) => {
  const users = await prisma.user.findMany(
    {
      include: {
        posts: true,
        reels: true,
        stories: true,
        // comments: true,
        // likes: true,
        followers: true,
        following: true,
        chats: true,
        messages: true,
        StoryView: true,
        // Share: true,
        MessageLike: true,
        blockedBy: true,
        blocking: true,
      },
      orderBy: { updatedAt: 'desc' },
    }
  );
  res.json(users);
};

export const getMe = async (req: Request, res: Response) => {
  const userId = req.userId;
  console.log(userId);
  try {
    const user = await prisma.user.findUnique({ where: { id: userId }, select: { id: true, email: true, username: true, bio: true, followers: true, following: true, posts: true, profileImage: true, blocking: true, comments: true, createdAt: true, likes: true, messages: true, reels: true, Share: true, stories: true, StoryView: true, updatedAt: true, blockedBy: true, MessageLike: true, } });
    res.status(200).json(user);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Fetching details failed", error: err.message });
  }
};

export const blockUser = async (req: Request, res: Response) => {
  const userId = req.userId!;
  const { targetUserId } = req.params;

  if (userId === targetUserId) {
    return res.status(400).json({ message: "You can't block yourself." });
  }

  try {
    await prisma.block.create({
      data: {
        blockerId: userId,
        blockedId: targetUserId,
      },
    });

    // Optional: remove follow if exists
    await prisma.follow.deleteMany({
      where: {
        OR: [
          { followerId: userId, followingId: targetUserId },
          { followerId: targetUserId, followingId: userId },
        ],
      },
    });

    res.json({ message: "User blocked successfully." });
  } catch (err) {
    res.status(500).json({ message: "Error blocking user", error: err.message });
  }
};

export const unblockUser = async (req: Request, res: Response) => {
  const userId = req.userId!;
  const { targetUserId } = req.params;

  try {
    await prisma.block.delete({
      where: {
        blockerId_blockedId: {
          blockerId: userId,
          blockedId: targetUserId,
        },
      },
    });

    res.json({ message: "User unblocked successfully." });
  } catch (err) {
    res.status(500).json({ message: "Error unblocking user", error: err.message });
  }
};

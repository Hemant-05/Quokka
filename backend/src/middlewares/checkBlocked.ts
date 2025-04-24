import { NextFunction, Request, Response } from 'express';
import { prisma } from '../prisma/client';


export const checkBlocked = async (req: Request, res: Response, next: NextFunction) => {
    const userId = req.userId!;
    const targetUserId = req.params.targetUserId || req.body.userId;
  
    const isBlocked = await prisma.block.findFirst({
      where: {
        OR: [
          { blockerId: targetUserId, blockedId: userId }, // You are blocked
          { blockerId: userId, blockedId: targetUserId }, // You have blocked them
        ],
      },
    });
  
    if (isBlocked) {
      return res.status(403).json({ message: "Access denied due to blocking." });
    }
  
    next();
  };
  
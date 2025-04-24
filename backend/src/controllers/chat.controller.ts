import { Request, Response } from 'express';
import { prisma } from '../prisma/client';

export const createChat = async (req: Request, res: Response) => {
    const { participantIds, isGroup, name, } = req.body;
    try {
        const chat = await prisma.chat.create({
            data: {
                participants: {
                    create: participantIds.map(id => ({
                        user: { connect: { id } }
                    }))
                },
                isGroup: isGroup,
                name: name
            },
            include: {
                participants: true,
            }
        });

        res.json(chat);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

export const sendMessage = async (req: Request, res: Response) => {
    const userId = req.userId!;
    const { chatId } = req.params;
    const { content, imageUrl, videoUrl } = req.body;

    try {
        const message = await prisma.message.create({
            data: {
                content: content,
                imageUrl: imageUrl,
                videoUrl: videoUrl,
                chat: { connect: { id: chatId } },
                sender: { connect: { id: userId } }
            }
        });

        res.json(message);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

export const getMessages = async (req: Request, res: Response) => {
    const { chatId } = req.params;

    try {
        const messages = await prisma.message.findMany({
            where: { chatId },
            include: { sender: true, likedBy: true },
            orderBy: { createdAt: 'asc' }
        });

        res.json(messages);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

export const markSeen = async (req: Request, res: Response) => {
    const userId = req.userId!;
    const { messageId } = req.params;

    try {
        await prisma.messageSeen.create({
            data: {
                user: { connect: { id: userId } },
                message: { connect: { id: messageId } }
            }
        });

        res.json({ message: "Marked as seen" });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

export const getUserChats = async (req: Request, res: Response) => {
    const userId = req.userId!;

    try {
        const chats = await prisma.chat.findMany({
            where: {
                participants: {
                    some: {
                        userId
                    }
                }
            },
            include: {
                participants: {
                    include: { user: true, chat: true, }
                },
                messages: {
                    orderBy: { createdAt: 'desc' },
                    take: 1
                }
            }
        });
        res.json(chats);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

export const deleteChat = async (req: Request, res: Response) => {
    const { chatId } = req.params;
    const userId = req.userId!;

    try {
        const chat = await prisma.chat.findUnique({
            where: { id: chatId },
            include: {
                participants: true,
            },
        });
        if (!chat) {
            return res.status(404).json({ message: "Chat not found !!!" });
        }
        const isUserInChat = chat.participants.some(p => p.userId == userId);
        if (!isUserInChat) {
            return res.status(403).json({ message: "You're not a participant in this chat " });
        }

        // Step 1: Delete messageLike entries (if applicable)
        await prisma.messageLike?.deleteMany({
            where: { message: { chatId } }
        });

        // Step 2: Delete messages in the chat
        await prisma.message.deleteMany({
            where: { chatId }
        });

        // Step 3: Delete participants
        await prisma.chatParticipant.deleteMany({
            where: { chatId }
        });

        // Step 4: Delete chat itself
        await prisma.chat.delete({
            where: { id: chatId }
        });

        res.json({ message: "Chat deleted Successfully...." });
    } catch (err) {
        res.status(500).json({ message: "Something went wrong ", error: err.message });
    }
};

export const deleteMessage = async (req: Request, res: Response) => {
    const userId = req.userId!;
    const { messageId } = req.params;
  
    try {
      const message = await prisma.message.findUnique({
        where: { id: messageId }
      });
  
      if (!message) {
        return res.status(404).json({ message: "Message not found" });
      }
  
      if (message.senderId !== userId) {
        return res.status(403).json({ message: "You can only delete your own messages" });
      }
  
      await prisma.message.delete({
        where: { id: messageId }
      });
  
      res.json({ message: "Message deleted successfully" });
    } catch (err) {
      res.status(500).json({ message: "Something went wrong", error: err.message });
    }
  };
  
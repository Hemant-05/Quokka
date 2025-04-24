import express from 'express';
import {
    sendMessage, getMessages, markSeen, getUserChats, createChat, deleteChat, deleteMessage
} from '../controllers/chat.controller';
import { isAuth } from '../middlewares/isAuth';

const router = express.Router();

router.post('/', isAuth, createChat);
router.get('/', isAuth, getUserChats);
router.post('/:chatId/messages', isAuth, sendMessage);
router.get('/:chatId/messages', isAuth, getMessages);
router.post('/messages/:messageId/seen', isAuth, markSeen);
router.delete('/:chatId', isAuth, deleteChat);
router.delete('/:chatId/:messageId', isAuth, deleteMessage);

export default router;

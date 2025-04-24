import express from 'express';
import {
    followUser, unfollowUser, getFollowers,
    getFollowing, getAllUsers,
    blockUser, unblockUser
} from '../controllers/user.controller';
import { isAuth } from '../middlewares/isAuth';

const router = express.Router();

router.get('/', isAuth, getAllUsers);
router.post('/follow/:targetUserId', isAuth, followUser);
router.post('/unfollow/:targetUserId', isAuth, unfollowUser);
router.get('/:userId/followers', isAuth, getFollowers);
router.get('/:userId/following', isAuth, getFollowing);
router.post('/block/:targetUserId', isAuth, blockUser);
router.post('/unblock/:targetUserId', isAuth, unblockUser);

export default router;

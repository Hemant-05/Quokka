/*
  Warnings:

  - You are about to drop the column `createdById` on the `Chat` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Chat` table. All the data in the column will be lost.
  - You are about to drop the column `isDeleted` on the `Comment` table. All the data in the column will be lost.
  - You are about to drop the column `parentCommentId` on the `Comment` table. All the data in the column will be lost.
  - You are about to drop the column `storyId` on the `Comment` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Comment` table. All the data in the column will be lost.
  - You are about to drop the column `followedId` on the `Follow` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `Follow` table. All the data in the column will be lost.
  - You are about to drop the column `commentId` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `messageId` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `isDeleted` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `replyToMessageId` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `sharedPostId` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `sharedReelId` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `textContent` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `caption` on the `Post` table. All the data in the column will be lost.
  - You are about to drop the column `isArchived` on the `Post` table. All the data in the column will be lost.
  - You are about to drop the column `location` on the `Post` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Post` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Post` table. All the data in the column will be lost.
  - You are about to drop the column `audioId` on the `Reel` table. All the data in the column will be lost.
  - You are about to drop the column `durationSeconds` on the `Reel` table. All the data in the column will be lost.
  - You are about to drop the column `isArchived` on the `Reel` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Reel` table. All the data in the column will be lost.
  - You are about to drop the column `highlightGroupId` on the `Story` table. All the data in the column will be lost.
  - You are about to drop the column `isHighlighted` on the `Story` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Story` table. All the data in the column will be lost.
  - You are about to drop the column `fullName` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `isPrivate` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `isVerified` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `lastActiveAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `passwordHash` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `profilePictureUrl` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Audio` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Block` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ChatMember` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Collection` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CommentMention` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Hashtag` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `HashtagUsage` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `HighlightGroup` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Media` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MessageStatus` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Notification` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SavedItem` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `followingId` to the `Follow` table without a default value. This is not possible if the table is not empty.
  - Added the required column `authorId` to the `Post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `authorId` to the `Reel` table without a default value. This is not possible if the table is not empty.
  - Added the required column `videoUrl` to the `Reel` table without a default value. This is not possible if the table is not empty.
  - Added the required column `authorId` to the `Story` table without a default value. This is not possible if the table is not empty.
  - Added the required column `mediaUrl` to the `Story` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Audio" DROP CONSTRAINT "Audio_originalUserId_fkey";

-- DropForeignKey
ALTER TABLE "Block" DROP CONSTRAINT "Block_blockedId_fkey";

-- DropForeignKey
ALTER TABLE "Block" DROP CONSTRAINT "Block_blockerId_fkey";

-- DropForeignKey
ALTER TABLE "Chat" DROP CONSTRAINT "Chat_createdById_fkey";

-- DropForeignKey
ALTER TABLE "ChatMember" DROP CONSTRAINT "ChatMember_chatId_fkey";

-- DropForeignKey
ALTER TABLE "ChatMember" DROP CONSTRAINT "ChatMember_userId_fkey";

-- DropForeignKey
ALTER TABLE "Collection" DROP CONSTRAINT "Collection_userId_fkey";

-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_parentCommentId_fkey";

-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_postId_fkey";

-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_reelId_fkey";

-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_storyId_fkey";

-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_userId_fkey";

-- DropForeignKey
ALTER TABLE "CommentMention" DROP CONSTRAINT "CommentMention_commentId_fkey";

-- DropForeignKey
ALTER TABLE "CommentMention" DROP CONSTRAINT "CommentMention_userId_fkey";

-- DropForeignKey
ALTER TABLE "Follow" DROP CONSTRAINT "Follow_followedId_fkey";

-- DropForeignKey
ALTER TABLE "Follow" DROP CONSTRAINT "Follow_followerId_fkey";

-- DropForeignKey
ALTER TABLE "HashtagUsage" DROP CONSTRAINT "HashtagUsage_hashtagId_fkey";

-- DropForeignKey
ALTER TABLE "HashtagUsage" DROP CONSTRAINT "HashtagUsage_postId_fkey";

-- DropForeignKey
ALTER TABLE "HashtagUsage" DROP CONSTRAINT "HashtagUsage_reelId_fkey";

-- DropForeignKey
ALTER TABLE "HashtagUsage" DROP CONSTRAINT "HashtagUsage_storyId_fkey";

-- DropForeignKey
ALTER TABLE "HighlightGroup" DROP CONSTRAINT "HighlightGroup_coverMediaId_fkey";

-- DropForeignKey
ALTER TABLE "HighlightGroup" DROP CONSTRAINT "HighlightGroup_userId_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_commentId_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_messageId_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_postId_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_reelId_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_userId_fkey";

-- DropForeignKey
ALTER TABLE "Media" DROP CONSTRAINT "Media_messageId_fkey";

-- DropForeignKey
ALTER TABLE "Media" DROP CONSTRAINT "Media_postId_fkey";

-- DropForeignKey
ALTER TABLE "Media" DROP CONSTRAINT "Media_reelId_fkey";

-- DropForeignKey
ALTER TABLE "Media" DROP CONSTRAINT "Media_storyId_fkey";

-- DropForeignKey
ALTER TABLE "Media" DROP CONSTRAINT "Media_userId_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_chatId_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_replyToMessageId_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_senderId_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_sharedPostId_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_sharedReelId_fkey";

-- DropForeignKey
ALTER TABLE "MessageStatus" DROP CONSTRAINT "MessageStatus_messageId_fkey";

-- DropForeignKey
ALTER TABLE "MessageStatus" DROP CONSTRAINT "MessageStatus_userId_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_actorId_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_userId_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_userId_fkey";

-- DropForeignKey
ALTER TABLE "Reel" DROP CONSTRAINT "Reel_audioId_fkey";

-- DropForeignKey
ALTER TABLE "Reel" DROP CONSTRAINT "Reel_userId_fkey";

-- DropForeignKey
ALTER TABLE "SavedItem" DROP CONSTRAINT "SavedItem_collectionId_fkey";

-- DropForeignKey
ALTER TABLE "SavedItem" DROP CONSTRAINT "SavedItem_postId_fkey";

-- DropForeignKey
ALTER TABLE "SavedItem" DROP CONSTRAINT "SavedItem_reelId_fkey";

-- DropForeignKey
ALTER TABLE "SavedItem" DROP CONSTRAINT "SavedItem_userId_fkey";

-- DropForeignKey
ALTER TABLE "Story" DROP CONSTRAINT "Story_highlightGroupId_fkey";

-- DropForeignKey
ALTER TABLE "Story" DROP CONSTRAINT "Story_userId_fkey";

-- DropForeignKey
ALTER TABLE "StoryView" DROP CONSTRAINT "StoryView_storyId_fkey";

-- DropForeignKey
ALTER TABLE "StoryView" DROP CONSTRAINT "StoryView_viewerId_fkey";

-- DropIndex
DROP INDEX "Chat_createdAt_idx";

-- DropIndex
DROP INDEX "Chat_createdById_idx";

-- DropIndex
DROP INDEX "Comment_createdAt_idx";

-- DropIndex
DROP INDEX "Comment_parentCommentId_idx";

-- DropIndex
DROP INDEX "Comment_postId_idx";

-- DropIndex
DROP INDEX "Comment_reelId_idx";

-- DropIndex
DROP INDEX "Comment_storyId_idx";

-- DropIndex
DROP INDEX "Comment_userId_idx";

-- DropIndex
DROP INDEX "Follow_followedId_idx";

-- DropIndex
DROP INDEX "Follow_followerId_followedId_key";

-- DropIndex
DROP INDEX "Follow_followerId_idx";

-- DropIndex
DROP INDEX "Like_commentId_idx";

-- DropIndex
DROP INDEX "Like_messageId_idx";

-- DropIndex
DROP INDEX "Like_postId_idx";

-- DropIndex
DROP INDEX "Like_reelId_idx";

-- DropIndex
DROP INDEX "Like_userId_commentId_key";

-- DropIndex
DROP INDEX "Like_userId_idx";

-- DropIndex
DROP INDEX "Like_userId_messageId_key";

-- DropIndex
DROP INDEX "Like_userId_postId_key";

-- DropIndex
DROP INDEX "Like_userId_reelId_key";

-- DropIndex
DROP INDEX "Message_chatId_idx";

-- DropIndex
DROP INDEX "Message_createdAt_idx";

-- DropIndex
DROP INDEX "Message_replyToMessageId_idx";

-- DropIndex
DROP INDEX "Message_senderId_idx";

-- DropIndex
DROP INDEX "Post_createdAt_idx";

-- DropIndex
DROP INDEX "Post_userId_idx";

-- DropIndex
DROP INDEX "Reel_audioId_idx";

-- DropIndex
DROP INDEX "Reel_createdAt_idx";

-- DropIndex
DROP INDEX "Reel_userId_idx";

-- DropIndex
DROP INDEX "Story_createdAt_idx";

-- DropIndex
DROP INDEX "Story_expiresAt_idx";

-- DropIndex
DROP INDEX "Story_highlightGroupId_idx";

-- DropIndex
DROP INDEX "Story_userId_idx";

-- DropIndex
DROP INDEX "StoryView_storyId_idx";

-- DropIndex
DROP INDEX "StoryView_storyId_viewerId_key";

-- DropIndex
DROP INDEX "StoryView_viewerId_idx";

-- DropIndex
DROP INDEX "User_createdAt_idx";

-- DropIndex
DROP INDEX "User_email_idx";

-- DropIndex
DROP INDEX "User_username_idx";

-- AlterTable
ALTER TABLE "Chat" DROP COLUMN "createdById",
DROP COLUMN "updatedAt";

-- AlterTable
ALTER TABLE "Comment" DROP COLUMN "isDeleted",
DROP COLUMN "parentCommentId",
DROP COLUMN "storyId",
DROP COLUMN "updatedAt";

-- AlterTable
ALTER TABLE "Follow" DROP COLUMN "followedId",
DROP COLUMN "status",
ADD COLUMN     "followingId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Like" DROP COLUMN "commentId",
DROP COLUMN "createdAt",
DROP COLUMN "messageId";

-- AlterTable
ALTER TABLE "Message" DROP COLUMN "isDeleted",
DROP COLUMN "replyToMessageId",
DROP COLUMN "sharedPostId",
DROP COLUMN "sharedReelId",
DROP COLUMN "textContent",
ADD COLUMN     "content" TEXT,
ADD COLUMN     "imageUrl" TEXT,
ADD COLUMN     "videoUrl" TEXT;

-- AlterTable
ALTER TABLE "Post" DROP COLUMN "caption",
DROP COLUMN "isArchived",
DROP COLUMN "location",
DROP COLUMN "updatedAt",
DROP COLUMN "userId",
ADD COLUMN     "authorId" TEXT NOT NULL,
ADD COLUMN     "content" TEXT,
ADD COLUMN     "imageUrl" TEXT,
ADD COLUMN     "videoUrl" TEXT;

-- AlterTable
ALTER TABLE "Reel" DROP COLUMN "audioId",
DROP COLUMN "durationSeconds",
DROP COLUMN "isArchived",
DROP COLUMN "userId",
ADD COLUMN     "authorId" TEXT NOT NULL,
ADD COLUMN     "videoUrl" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Story" DROP COLUMN "highlightGroupId",
DROP COLUMN "isHighlighted",
DROP COLUMN "userId",
ADD COLUMN     "authorId" TEXT NOT NULL,
ADD COLUMN     "mediaUrl" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "fullName",
DROP COLUMN "isPrivate",
DROP COLUMN "isVerified",
DROP COLUMN "lastActiveAt",
DROP COLUMN "passwordHash",
DROP COLUMN "profilePictureUrl",
ADD COLUMN     "password" TEXT NOT NULL,
ADD COLUMN     "profileImage" TEXT;

-- DropTable
DROP TABLE "Audio";

-- DropTable
DROP TABLE "Block";

-- DropTable
DROP TABLE "ChatMember";

-- DropTable
DROP TABLE "Collection";

-- DropTable
DROP TABLE "CommentMention";

-- DropTable
DROP TABLE "Hashtag";

-- DropTable
DROP TABLE "HashtagUsage";

-- DropTable
DROP TABLE "HighlightGroup";

-- DropTable
DROP TABLE "Media";

-- DropTable
DROP TABLE "MessageStatus";

-- DropTable
DROP TABLE "Notification";

-- DropTable
DROP TABLE "SavedItem";

-- CreateTable
CREATE TABLE "Share" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "postId" TEXT,
    "reelId" TEXT,

    CONSTRAINT "Share_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChatParticipant" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "chatId" TEXT NOT NULL,
    "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ChatParticipant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MessageLike" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "messageId" TEXT NOT NULL,

    CONSTRAINT "MessageLike_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reel" ADD CONSTRAINT "Reel_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Story" ADD CONSTRAINT "Story_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StoryView" ADD CONSTRAINT "StoryView_storyId_fkey" FOREIGN KEY ("storyId") REFERENCES "Story"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StoryView" ADD CONSTRAINT "StoryView_viewerId_fkey" FOREIGN KEY ("viewerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_reelId_fkey" FOREIGN KEY ("reelId") REFERENCES "Reel"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Like" ADD CONSTRAINT "Like_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Like" ADD CONSTRAINT "Like_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Like" ADD CONSTRAINT "Like_reelId_fkey" FOREIGN KEY ("reelId") REFERENCES "Reel"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Share" ADD CONSTRAINT "Share_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Share" ADD CONSTRAINT "Share_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Share" ADD CONSTRAINT "Share_reelId_fkey" FOREIGN KEY ("reelId") REFERENCES "Reel"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Follow" ADD CONSTRAINT "Follow_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Follow" ADD CONSTRAINT "Follow_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChatParticipant" ADD CONSTRAINT "ChatParticipant_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChatParticipant" ADD CONSTRAINT "ChatParticipant_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES "Chat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES "Chat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MessageLike" ADD CONSTRAINT "MessageLike_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MessageLike" ADD CONSTRAINT "MessageLike_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "Message"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

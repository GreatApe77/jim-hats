/*
  Warnings:

  - You are about to drop the column `gymChallengeId` on the `users` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_gymChallengeId_fkey";

-- AlterTable
ALTER TABLE "users" DROP COLUMN "gymChallengeId";

-- CreateTable
CREATE TABLE "_GymChallengeToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_GymChallengeToUser_AB_unique" ON "_GymChallengeToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_GymChallengeToUser_B_index" ON "_GymChallengeToUser"("B");

-- AddForeignKey
ALTER TABLE "_GymChallengeToUser" ADD CONSTRAINT "_GymChallengeToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "gym_challenges"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GymChallengeToUser" ADD CONSTRAINT "_GymChallengeToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

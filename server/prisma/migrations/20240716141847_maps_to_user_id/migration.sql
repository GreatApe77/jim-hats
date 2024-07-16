/*
  Warnings:

  - You are about to drop the column `gymChallengeId` on the `exercise_logs` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `exercise_logs` table. All the data in the column will be lost.
  - Added the required column `gym_challenge_id` to the `exercise_logs` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `exercise_logs` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "exercise_logs" DROP CONSTRAINT "exercise_logs_gymChallengeId_fkey";

-- DropForeignKey
ALTER TABLE "exercise_logs" DROP CONSTRAINT "exercise_logs_userId_fkey";

-- AlterTable
ALTER TABLE "exercise_logs" DROP COLUMN "gymChallengeId",
DROP COLUMN "userId",
ADD COLUMN     "gym_challenge_id" INTEGER NOT NULL,
ADD COLUMN     "user_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "exercise_logs" ADD CONSTRAINT "exercise_logs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exercise_logs" ADD CONSTRAINT "exercise_logs_gym_challenge_id_fkey" FOREIGN KEY ("gym_challenge_id") REFERENCES "gym_challenges"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

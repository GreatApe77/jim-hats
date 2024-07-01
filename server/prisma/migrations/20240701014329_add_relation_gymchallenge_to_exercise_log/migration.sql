/*
  Warnings:

  - Added the required column `gymChallengeId` to the `exercise_logs` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "exercise_logs" ADD COLUMN     "gymChallengeId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "exercise_logs" ADD CONSTRAINT "exercise_logs_gymChallengeId_fkey" FOREIGN KEY ("gymChallengeId") REFERENCES "gym_challenges"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

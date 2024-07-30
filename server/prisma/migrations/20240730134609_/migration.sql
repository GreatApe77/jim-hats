/*
  Warnings:

  - A unique constraint covering the columns `[joinId]` on the table `gym_challenges` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "gym_challenges" ADD COLUMN     "joinId" VARCHAR(255);

-- CreateIndex
CREATE UNIQUE INDEX "gym_challenges_joinId_key" ON "gym_challenges"("joinId");

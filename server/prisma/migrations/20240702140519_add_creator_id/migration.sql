/*
  Warnings:

  - Added the required column `creator_id` to the `gym_challenges` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "gym_challenges" ADD COLUMN     "creator_id" INTEGER NOT NULL;

/*
  Warnings:

  - You are about to alter the column `name` on the `gym_challenges` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `username` on the `users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `email` on the `users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `password` on the `users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `profile_picture` on the `users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - Added the required column `end_at` to the `gym_challenges` table without a default value. This is not possible if the table is not empty.
  - Added the required column `start_at` to the `gym_challenges` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "gym_challenges" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "end_at" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "start_at" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "name" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "image" DROP NOT NULL;

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "username" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "email" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "password" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "profile_picture" SET DATA TYPE VARCHAR(255);

-- CreateTable
CREATE TABLE "exercise_logs" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "image" TEXT,
    "date" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "exercise_logs_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "exercise_logs" ADD CONSTRAINT "exercise_logs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

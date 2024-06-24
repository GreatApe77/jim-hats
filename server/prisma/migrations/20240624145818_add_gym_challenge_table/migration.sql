-- AlterTable
ALTER TABLE "users" ADD COLUMN     "gymChallengeId" INTEGER;

-- CreateTable
CREATE TABLE "gym_challenges" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "image" TEXT NOT NULL,

    CONSTRAINT "gym_challenges_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_gymChallengeId_fkey" FOREIGN KEY ("gymChallengeId") REFERENCES "gym_challenges"("id") ON DELETE SET NULL ON UPDATE CASCADE;

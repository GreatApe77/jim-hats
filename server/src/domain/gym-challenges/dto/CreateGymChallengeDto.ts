import { z } from "zod";


export const CreateGymChallengeSchema = z.object({
    name:z.string(),
    description:z.string(),
    image:z.string().url().nullable(),
    startAt:z.date().min(new Date()),
    endAt:z.date(),
})
export type CreateGymChallengeDto = z.infer<typeof CreateGymChallengeSchema>
/* 

model GymChallenge {
    id          Int           @id @default(autoincrement())
    name        String        @db.VarChar(255)
    description String
    image       String?
    createdAt   DateTime      @default(now()) @map("created_at")
    startAt     DateTime      @map("start_at")
    endAt       DateTime      @map("end_at")
    members     User[]
    logs        ExerciseLog[]
   */
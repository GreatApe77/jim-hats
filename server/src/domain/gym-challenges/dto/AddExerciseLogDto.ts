import { z } from "zod";

export const AddExerciseLogSchema = z.object({
  description: z.string().optional(),
  title: z.string(),
  image: z.string().url(),
});

export type AddExerciseLogDto = z.infer<typeof AddExerciseLogSchema>;

export const AddExerciseLogParamsSchema = z.object({
  challengeId: z.coerce.number(),
});

export type AddExerciseLogParamsDto = z.infer<
  typeof AddExerciseLogParamsSchema
>;

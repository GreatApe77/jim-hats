import { z } from "zod";

export const UpdateGymChallengeSchema = z.object({
  id: z.number().int(),
  name: z.string().optional(),
  description: z.string().optional(),
  image: z.string().url().optional(),
});

export type UpdateGymChallengeDto = z.infer<typeof UpdateGymChallengeSchema>;

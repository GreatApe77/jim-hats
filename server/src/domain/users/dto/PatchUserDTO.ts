import { z } from "zod";

export const PatchUserSchema = z.object({
    email: z.string().email().optional(),
    username: z.string()
        .min(3)
        .max(20)
        .regex(/^[^\s@]+$/).optional(),
    profilePicture: z.string().url().nullable().optional(),
}).strict();

export type PatchUserDTO = z.infer<typeof PatchUserSchema>
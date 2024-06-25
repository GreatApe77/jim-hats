import { z } from "zod";
import { MESSAGES } from "../../../../constants/MESSAGES";




const RegisterUserSchema = z.object({
    email: z.string().email(),
    password: z.string().min(6).max(20),
    username: z.string()
        .min(3)
        .max(20)
        .regex(/^[^\s@]+$/, MESSAGES.INVALID_USERNAME),
    profilePicture: z.string().url().nullable().optional(),
});

export {
    RegisterUserSchema
}
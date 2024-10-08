import { z } from "zod";
import { MESSAGES } from "../../../../constants/MESSAGES.js";

const LoginUserSchema = z.object({
  password: z.string().min(6).max(20),
  username: z
    .string()
    .min(3)
    .max(20)
    .regex(/^[^\s@]+$/, MESSAGES.INVALID_USERNAME),
});

export { LoginUserSchema };

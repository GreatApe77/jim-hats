import "dotenv/config";
import { z } from "zod";

const envSchema = z.object({
  PORT: z.string().default("4000"),
  NODE_ENV: z.enum(["dev", "test", "prod"]).default("dev"),
  DATABASE_URL: z.string().default(""),
  JWT_SECRET: z.string().default("JWT_SECRET"),
});

export const environment = envSchema.parse(process.env);

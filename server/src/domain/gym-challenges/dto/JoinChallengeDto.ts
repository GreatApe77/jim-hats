import { z } from "zod";

export const JoinChallengeDtoParamsSchema = z.object({
  joinId: z.string().uuid(),
});

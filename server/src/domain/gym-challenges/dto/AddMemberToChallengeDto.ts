import { z } from "zod";

export const AddMemberToChallengeSchema = z.object({
  username: z.string(),
});
export const AddMemberToChallengeParamsSchema = z.object({
  challengeId: z.coerce.number(),
});
export type AddMemberToChallengeParamsDto = z.infer<
  typeof AddMemberToChallengeParamsSchema
>;
export type AddMemberToChallengeDto = z.infer<
  typeof AddMemberToChallengeSchema
>;

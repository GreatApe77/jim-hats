import { format, isAfter, isFuture, isValid, parse } from "date-fns";
import { z } from "zod";

function dateInFutureOrPresent(value: string) {
  const parsedDate = parse(value, "dd/MM/yyyy", new Date());
  return (
    isValid(parsedDate) &&
    (isFuture(parsedDate) ||
      format(parsedDate, "dd/MM/yyyy") === format(new Date(), "dd/MM/yyyy"))
  );
}

export const CreateGymChallengeSchema = z
  .object({
    name: z.string(),
    description: z.string().nullable(),
    image: z.string().url().nullable(),
    startAt: z.string().refine(dateInFutureOrPresent),
    endAt: z.string().refine(dateInFutureOrPresent),
  })
  .refine(
    (data) => {
      const startAtDate = parse(data.startAt, "dd/MM/yyyy", new Date());
      const endAtDate = parse(data.endAt, "dd/MM/yyyy", new Date());
      return isAfter(endAtDate, startAtDate);
    },
    {
      path: ["endAt"],
    },
  );

export type CreateGymChallengeDto = z.infer<typeof CreateGymChallengeSchema>;

import { MESSAGES } from "../constants/MESSAGES";

export class HttpError extends Error {
  constructor(
    public statusCode: number = 500,
    public message: string = MESSAGES.INTERNAL_SERVER_ERROR,
  ) {
    super(message);
  }
}

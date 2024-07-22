import { Response } from "express";
import { environment } from "../config/environment.js";
import { MESSAGES } from "../constants/MESSAGES.js";
import { errorResponse } from "../utils/responses.js";
import { HttpError } from "./HttpError.js";

export function handleErrors(error: unknown, res: Response) {
  if (error instanceof HttpError) {
    if (environment.NODE_ENV !== "test" && error.statusCode == 500) {
      console.error(error);
    }
    return res.status(error.statusCode).json(errorResponse(error.message));
  }
  console.error(error);
  return res.status(500).json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
}

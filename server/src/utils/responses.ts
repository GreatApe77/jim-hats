import { ErrorResponseFormat } from "../types/ErrorResponseFormat.js";
import { SuccessResponseFormat } from "../types/SuccessResponseFormat.js";

export function successResponse<T>(
  message: string,
  data?: T,
): SuccessResponseFormat<T> {
  return {
    message,
    data,
  };
}
export function errorResponse(message: string): ErrorResponseFormat {
  return {
    message,
  };
}

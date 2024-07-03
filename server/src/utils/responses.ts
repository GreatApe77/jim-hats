import { ErrorResponseFormat } from "../types/ErrorResponseFormat";
import { SuccessResponseFormat } from "../types/SuccessResponseFormat";

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

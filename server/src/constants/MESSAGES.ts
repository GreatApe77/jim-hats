import { INVALID } from "zod";

export const MESSAGES = {
  INVALID_JWT_TOKEN_FORMAT:
    "Invalid JWT token format. Format should be 'Bearer <token>'",
  INVALID_JWT_TOKEN: "Invalid JWT",
  REGISTERED_USER: "Registered user",
  LOGIN_USER_SUCCESS: "Logged in",
  INTERNAL_SERVER_ERROR: "Internal server error",
  USER_NOT_FOUND: "User not found",
  USER_FOUND: "User found",
  INVALID_USERNAME: "Username cannot contain spaces or @ symbol",
  BAD_REQUEST: "Bad request",
  USERS_FOUND: "Users found",
  USER_ALREADY_EXISTS: "User already exists",
  WRONG_PASSWORD: "Wrong password",
  UNAUTHORIZED: "Unauthorized",
  USER_DELETED: "User deleted",
  USER_UPDATED: "User updated",
  PROFILE_PICTURE_UPDATED: "Profile picture updated",
  INVALID_FILE_TYPE: "Profile picture should be a jpeg or png file",
  CREATED: "Created",
  UPDATED: "Updated",
  SUCCESS: "Success",
  NOT_FOUND: "Not found",
  FORBIDDEN: "Forbidden",
};

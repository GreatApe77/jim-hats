import { IUser } from "../../users/IUser.js";
export type RegisterUserDTO = Pick<
  IUser,
  "email" | "username" | "profilePicture" | "password"
>;

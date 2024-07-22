import { IUser } from "../../users/IUser.js";

export type LoginUserDTO = Pick<IUser, "username" | "password">;

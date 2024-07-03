import { IUser } from "../../users/IUser";

export type LoginUserDTO = Pick<IUser, "username" | "password">;

import { IUser } from "../../../users/IUser.js";
import { SaveUserParams } from "../../../users/repository/interfaces/IUserRepository.js";
export type DecodedPayload = Pick<IUser, "id" | "username">;
export interface IAuthService {
  register(user: SaveUserParams): Promise<void>;
  login(username: string, password: string): Promise<string>;
  verifyToken(token: string): Promise<DecodedPayload>;
}

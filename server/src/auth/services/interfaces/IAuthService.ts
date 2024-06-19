import { IUser } from "../../../users/IUser";
import { SaveUserParams } from "../../../users/repository/interfaces/IUserRepository";
export type DecodedPayload = Pick<IUser,"id">
export interface IAuthService {
    register(user:SaveUserParams): Promise<void>
    login(username:string,password:string):Promise<string>
    verifyToken(token:string):Promise<DecodedPayload>
}
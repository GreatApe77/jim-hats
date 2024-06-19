import { SaveUserParams } from "../../../users/repository/interfaces/IUserRepository";

export interface IAuthService {
    register(user:SaveUserParams): Promise<void>
    login(username:string,password:string):Promise<string>
    verifyToken(token:string):Promise<boolean>
}
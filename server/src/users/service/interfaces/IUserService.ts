import { IUser } from "../../IUser";

export interface IUserService {
    search(prop:string):Promise<IUser|null>
}
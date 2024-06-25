import { IUser } from "../../IUser";
import { PaginationParams, UpdateUserParams } from "../../repository/interfaces/IUserRepository";

export interface IUserService {
    search(prop:string):Promise<IUser|null>
    list(paginationParams?:PaginationParams):Promise<IUser[]>
    list(dateFilter:Date):Promise<IUser[]>
    delete(id:number):Promise<void>
    update(id:number,user:UpdateUserParams):Promise<void>
}
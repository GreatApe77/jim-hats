import { IUser } from "../../IUser";

export type SaveUserParams = Pick<IUser,"email"|"password"|"createdAt"|"profilePicture"|"username">;
export type UpdateUserParams = Pick<IUser,"email"|"password"|"profilePicture"|"username">;
export type PaginationParams = {
    offset?:number;
    limit?:number;
}
export interface IUserRepository {
    save(user:SaveUserParams): Promise<void>;
    findByEmail(email:string): Promise<IUser | null>;
    findById(id:number): Promise<IUser | null>;
    findByUsername(username:string): Promise<IUser | null>;
    findAll(paginationParams:PaginationParams): Promise<IUser[]>;
    update(id:number, user:UpdateUserParams): Promise<void>;
    delete(id:number): Promise<void>;
}
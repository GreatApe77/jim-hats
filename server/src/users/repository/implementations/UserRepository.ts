import { IUser } from "../../IUser";
import { IUserRepository, PaginationParams, SaveUserParams, UpdateUserParams } from "../interfaces/IUserRepository";

export class UserRepository implements IUserRepository{
    save(user: SaveUserParams): Promise<void> {
        throw new Error("Method not implemented.");
    }
    findByEmail(email: string): Promise<IUser | null> {
        throw new Error("Method not implemented.");
    }
    findById(id: number): Promise<IUser | null> {
        throw new Error("Method not implemented.");
    }
    findByUsername(username: string): Promise<IUser | null> {
        throw new Error("Method not implemented.");
    }
    findAll(paginationParams: PaginationParams): Promise<IUser[]> {
        throw new Error("Method not implemented.");
    }
    update(id: number, user: UpdateUserParams): Promise<void> {
        throw new Error("Method not implemented.");
    }
    delete(id: number): Promise<void> {
        throw new Error("Method not implemented.");
    }
}
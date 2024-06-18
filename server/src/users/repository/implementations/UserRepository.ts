import { getDb } from "../../../db/db";
import { IUser } from "../../IUser";
import {
  IUserRepository,
  PaginationParams,
  SaveUserParams,
  UpdateUserParams,
} from "../interfaces/IUserRepository";

export class UserRepository implements IUserRepository {
  async save(user: SaveUserParams): Promise<void> {
    const prisma = getDb();
    await prisma.user.create({ data: user });
  }
  findByEmail(email: string): Promise<IUser | null> {
    const prisma = getDb()
    return prisma.user.findUnique({
        where:{
            email
        }
    })
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

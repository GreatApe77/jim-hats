import prisma from "../../../db/prisma";
import { IUser } from "../../IUser";
import {
  IUserRepository,
  PaginationParams,
  SaveUserParams,
  UpdateUserParams,
} from "../interfaces/IUserRepository";

export class UserRepository implements IUserRepository {
  async save(user: SaveUserParams): Promise<void> {
    await prisma.user.create({ data: user });
  }
  findByEmail(email: string): Promise<IUser | null> {
    return prisma.user.findUnique({
      where: {
        email,
      },
    });
  }
  findById(id: number): Promise<IUser | null> {
    return prisma.user.findUnique({
      where: {
        id,
      },
    });
  }
  findByUsername(username: string): Promise<IUser | null> {
    return prisma.user.findUnique({
      where: {
        username,
      },
    });
  }
  findAll({ limit = 30, offset = 0 }: PaginationParams): Promise<IUser[]> {
    return prisma.user.findMany({
      take: limit,
      skip: offset,
    });
  }
  
  async update(id: number, user: UpdateUserParams): Promise<void> {
    await prisma.user.update({
      where: { id },
      data: {
        updatedAt: new Date(),
        username: user.username,
        email: user.email,
        password: user.password,
        profilePicture: user.profilePicture,
      },
    });
  }
  async delete(id: number): Promise<void> {
    await prisma.user.delete({
      where: {
        id,
      },
    });
  }
}

import prisma from "../../../../db/prisma.js";
import { IUser } from "../../IUser.js";
import {
  IUserRepository,
  PaginationParams,
  SaveUserParams,
  UpdateUserParams,
} from "../interfaces/IUserRepository.js";

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
  findAll(args?: PaginationParams | Date): Promise<IUser[]> {
    if (args instanceof Date) {
      return prisma.user.findMany({
        orderBy: {
          createdAt: "desc",
        },
        where: {
          createdAt: {
            lt: args,
          },
        },
        take: 30,
      });
    } else {
      const { limit = 30, offset = 0 } = args || {};
      return prisma.user.findMany({
        take: limit,
        skip: offset,
      });
    }
  }

  async update(id: number, user: UpdateUserParams): Promise<void> {
    const userToUpdate = {
      ...user,
    };
    if (!user.password) {
      delete userToUpdate.password;
    }
    if (!user.email) {
      delete userToUpdate.email;
    }
    if (!user.username) {
      delete userToUpdate.username;
    }
    if (!user.profilePicture) {
      delete userToUpdate.profilePicture;
    }
    await prisma.user.update({
      where: { id },
      data: {
        updatedAt: new Date(),
        ...userToUpdate,
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

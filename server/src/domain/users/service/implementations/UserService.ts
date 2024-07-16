import { PrismaClient } from "@prisma/client";
import { PrismaClientKnownRequestError } from "@prisma/client/runtime/library";
import { MESSAGES } from "../../../../constants/MESSAGES";
import { HttpError } from "../../../../errors/HttpError";
import { IGymChallenge } from "../../../gym-challenges/IGymChallenge";
import { IUser } from "../../IUser";
import {
  IUserRepository,
  PaginationParams,
} from "../../repository/interfaces/IUserRepository";
import { IUserService } from "../interfaces/IUserService";

export class UserService implements IUserService {
  private userRepository: IUserRepository;
  private prismaClient: PrismaClient;
  constructor(userRepository: IUserRepository, prismaClient: PrismaClient) {
    this.userRepository = userRepository;
    this.prismaClient = prismaClient;
  }
  async getChallengesOfUser(userId: number): Promise<IGymChallenge[]> {
    const userWithChallenges = await this.prismaClient.user.findUnique({
      where: { id: userId },
      include: {
        gymChallenges: true,
      },
    });
    return userWithChallenges?.gymChallenges || [];
  }

  async update(
    id: number,
    user: Partial<
      Pick<IUser, "email" | "password" | "profilePicture" | "username">
    >,
  ): Promise<void> {
    try {
      await this.userRepository.update(id, user);
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === "P2025") {
          throw new HttpError(404, MESSAGES.USER_NOT_FOUND);
        }
      }
      throw error;
    }
  }
  search(prop: string): Promise<IUser | null> {
    if (prop.includes("@")) {
      return this.userRepository.findByEmail(prop);
    }

    if (!isNaN(parseInt(Number(prop).toString()))) {
      return this.userRepository.findById(Number(prop));
    }

    return this.userRepository.findByUsername(prop);
  }
  list(args?: PaginationParams | Date): Promise<IUser[]> {
    if (args instanceof Date) {
      return this.userRepository.findAll(args);
    }
    return this.userRepository.findAll(args);
  }
  async delete(id: number): Promise<void> {
    try {
      await this.userRepository.delete(id);
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === "P2025") {
          throw new HttpError(404, MESSAGES.USER_NOT_FOUND);
        }
      }
      throw error;
    }
  }
}

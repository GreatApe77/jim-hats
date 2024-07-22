import prisma from "../../../../db/prisma.js";
import { PaginationParams } from "../../../users/repository/interfaces/IUserRepository.js";
import { IGymChallenge } from "../../IGymChallenge.js";
import {
  CreateGymChallengeParams,
  IGymChallengeRepository,
} from "../interfaces/IGymChallengeRepository.js";

export class GymChallengeRepository implements IGymChallengeRepository {
  async save(gymChallenge: CreateGymChallengeParams): Promise<IGymChallenge> {
    return await prisma.gymChallenge.create({
      data: gymChallenge,
    });
  }
  async list(paginationParams?: PaginationParams): Promise<IGymChallenge[]> {
    return prisma.gymChallenge.findMany({
      take: paginationParams?.limit ? paginationParams.limit : 20,
      skip: paginationParams?.offset ? paginationParams.offset : 0,
      orderBy: { createdAt: "desc" },
    });
  }
  async getById(id: number): Promise<IGymChallenge | null> {
    return prisma.gymChallenge.findUnique({
      where: {
        id,
      },
    });
  }
  async update(
    id: number,
    updatedGymChallenge: Partial<CreateGymChallengeParams>,
  ): Promise<void> {
    await prisma.gymChallenge.update({
      where: {
        id,
      },
      data: updatedGymChallenge,
    });
  }
  async delete(id: number): Promise<void> {
    await prisma.gymChallenge.delete({
      where: { id },
    });
  }
}

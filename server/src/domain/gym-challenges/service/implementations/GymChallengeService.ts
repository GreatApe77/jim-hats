import { PrismaClient } from "@prisma/client";
import { IExerciseLog } from "../../../exercise-logs/IExerciseLog";
import { PaginationParams } from "../../../users/repository/interfaces/IUserRepository";
import { IGymChallenge } from "../../IGymChallenge";
import {
  CreateGymChallengeParams,
  IGymChallengeRepository,
} from "../../repository/interfaces/IGymChallengeRepository";
import {
  CreateExerciseLogParams,
  IGymChallengeService,
} from "../interfaces/IGymChallengeService";

export class GymChallengeService implements IGymChallengeService {
  private gymChallengeRepo: IGymChallengeRepository;
  private prismaClient: PrismaClient;
  constructor(
    gymChallengeRepo: IGymChallengeRepository,
    prismaClient: PrismaClient,
  ) {
    this.gymChallengeRepo = gymChallengeRepo;
    this.prismaClient = prismaClient;
  }
  async addLogToChallenge(
    challengeId: number,
    exerciseLog: CreateExerciseLogParams,
  ): Promise<IExerciseLog> {
    const result = await this.prismaClient.gymChallenge.update({
      where: {
        id: challengeId,
      },
      include: {
        logs: {
          take: 1,
          orderBy: {
            date: "desc",
          },
        },
      },
      data: {
        logs: {
          create: exerciseLog,
        },
      },
    });
    return result.logs[0];
  }
  async save(params: CreateGymChallengeParams): Promise<IGymChallenge> {
    return await this.gymChallengeRepo.save(params);
  }

  list(paginationParams?: PaginationParams): Promise<IGymChallenge[]> {
    return this.gymChallengeRepo.list(paginationParams);
  }

  getById(id: number): Promise<IGymChallenge | null> {
    return this.gymChallengeRepo.getById(id);
  }
  update(
    id: number,
    updatedGymChallenge: Partial<CreateGymChallengeParams>,
  ): Promise<void> {
    return this.gymChallengeRepo.update(id, updatedGymChallenge);
  }
  delete(id: number): Promise<void> {
    return this.gymChallengeRepo.delete(id);
  }
  async getUsersOfChallenge(challengeId: number) {
    const result = await this.prismaClient.gymChallenge.findUnique({
      select: {
        members: {
          select: {
            id: true,
            username: true,
            email: true,
            profilePicture: true,
            createdAt: true,
            updatedAt: true,
          },
        },
      },
      where: {
        id: challengeId,
      },
    });
    return result?.members ?? [];
  }
  async addMemberToChallenge(challengeId: number, memberId: number) {
    await this.prismaClient.gymChallenge.update({
      where: {
        id: challengeId,
      },
      data: {
        members: {
          connect: {
            id: memberId,
          },
        },
      },
    });
  }
  async getLogsGroupedByUsers(
    challengeId: number,
    pageSize: number = 10,
    offset: number = 0,
  ) {
    const result = await this.prismaClient.gymChallenge.findUnique({
      where: {
        id: challengeId,
      },
      include: {
        logs: {
          take:pageSize,
          skip: offset,
          orderBy: {
            date: "desc",
          },
          include: {
            user: {
              select: {
                username: true,
                profilePicture: true,
              },
            },
          },
        },
      },
    });
    return result?.logs ?? [];
  }
}

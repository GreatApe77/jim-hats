import { IExerciseLog } from "../../../exercise-logs/IExerciseLog.js";
import { IUser } from "../../../users/IUser.js";
import { PaginationParams } from "../../../users/repository/interfaces/IUserRepository.js";
import { IGymChallenge } from "../../IGymChallenge.js";
import {
  CreateGymChallengeParams,
  UpdateGymChallengeParams,
} from "../../repository/interfaces/IGymChallengeRepository.js";
export type CreateExerciseLogParams = Pick<
  IExerciseLog,
  "date" | "description" | "title" | "userId" | "image"
>;
export interface IGymChallengeService {
  save(params: CreateGymChallengeParams): Promise<IGymChallenge>;
  list(): Promise<IGymChallenge[]>;
  list(paginationParams: PaginationParams): Promise<IGymChallenge[]>;
  getById(id: number): Promise<IGymChallenge | null>;
  update(
    id: number,
    updatedGymChallenge: UpdateGymChallengeParams,
  ): Promise<void>;
  delete(id: number): Promise<void>;
  getUsersOfChallenge(challengeId: number): Promise<Omit<IUser, "password">[]>;
  addMemberToChallenge(challengeId: number, memberId: number): Promise<void>;
  addLogToChallenge(
    challengeId: number,
    exerciseLog: CreateExerciseLogParams,
  ): Promise<IExerciseLog>;
  getLogsGroupedByUsers(
    challengeId: number,
    take?: number,
    offset?: number,
  ): Promise<unknown>;
}

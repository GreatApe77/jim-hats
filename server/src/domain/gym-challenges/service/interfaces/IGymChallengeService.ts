import { IExerciseLog } from "../../../exercise-logs/IExerciseLog";
import { IUser } from "../../../users/IUser";
import { PaginationParams } from "../../../users/repository/interfaces/IUserRepository";
import { IGymChallenge } from "../../IGymChallenge";
import {
  CreateGymChallengeParams,
  UpdateGymChallengeParams,
} from "../../repository/interfaces/IGymChallengeRepository";
export type CreateExerciseLogParams = Pick<IExerciseLog,"date"|"description"|"title"|"userId"|"image">
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
  getUsersOfChallenge(challengeId: number): Promise<Omit<IUser,"password">[]>;
  addMemberToChallenge(challengeId: number,memberId:number):Promise<void>
  addLogToChallenge(challengeId: number,exerciseLog:CreateExerciseLogParams):Promise<IExerciseLog>
  getLogsGroupedByUsers(challengeId: number,take?:number,offset?:number):Promise<unknown>
}

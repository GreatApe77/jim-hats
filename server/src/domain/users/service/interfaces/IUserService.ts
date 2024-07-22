import { ExerciseLog } from "@prisma/client";
import { IGymChallenge } from "../../../gym-challenges/IGymChallenge.js";
import { IUser } from "../../IUser.js";
import {
  PaginationParams,
  UpdateUserParams,
} from "../../repository/interfaces/IUserRepository.js";

export interface IUserService {
  search(prop: string): Promise<IUser | null>;
  list(paginationParams?: PaginationParams): Promise<IUser[]>;
  list(dateFilter: Date): Promise<IUser[]>;
  delete(id: number): Promise<void>;
  update(id: number, user: UpdateUserParams): Promise<void>;
  getChallengesOfUser(userId: number): Promise<IGymChallenge[]>;
  getLogsOfUser(userId: number): Promise<ExerciseLog[]>;
}

import { PaginationParams } from "../../../users/repository/interfaces/IUserRepository";
import { IGymChallenge } from "../../IGymChallenge";
import {
  CreateGymChallengeParams,
  UpdateGymChallengeParams,
} from "../../repository/interfaces/IGymChallengeRepository";

export interface IGymChallengeService {
  save(params: CreateGymChallengeParams): Promise<void>;
  list(): Promise<IGymChallenge[]>;
  list(paginationParams: PaginationParams): Promise<IGymChallenge[]>;
  getById(id: number): Promise<IGymChallenge | null>;
  update(
    id: number,
    updatedGymChallenge: UpdateGymChallengeParams,
  ): Promise<void>;
  delete(id: number): Promise<void>;
}

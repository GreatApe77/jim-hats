import { PaginationParams } from "../../../users/repository/interfaces/IUserRepository.js";
import { IGymChallenge } from "../../IGymChallenge.js";
export type CreateGymChallengeParams = Pick<
  IGymChallenge,
  "name" | "image" | "startAt" | "endAt" | "description"|"creatorId"
>;
export type UpdateGymChallengeParams = Partial<CreateGymChallengeParams>;
export interface IGymChallengeRepository {
  save(gymChallenge: CreateGymChallengeParams): Promise<IGymChallenge>;
  list(): Promise<IGymChallenge[]>;
  list(paginationParams?: PaginationParams): Promise<IGymChallenge[]>;
  getById(id: number): Promise<IGymChallenge | null>;
  update(
    id: number,
    updatedGymChallenge: UpdateGymChallengeParams,
  ): Promise<void>;
  delete(id: number): Promise<void>;
}

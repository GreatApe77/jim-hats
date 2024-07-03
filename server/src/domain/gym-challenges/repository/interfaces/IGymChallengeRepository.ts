import { IGymChallenge } from "../../IGymChallenge";
export type CreateGymChallengeParams = Pick<
  IGymChallenge,
  "name" | "image" | "startAt" | "endAt" | "description"
>;
export type UpdateGymChallengeParams = Partial<CreateGymChallengeParams>;
import { PaginationParams } from "../../../users/repository/interfaces/IUserRepository";
export interface IGymChallengeRepository {
  save(gymChallenge: CreateGymChallengeParams): Promise<void>;
  list(): Promise<IGymChallenge[]>;
  list(paginationParams?: PaginationParams): Promise<IGymChallenge[]>;
  getById(id: number): Promise<IGymChallenge | null>;
  update(
    id: number,
    updatedGymChallenge: UpdateGymChallengeParams,
  ): Promise<void>;
  delete(id: number): Promise<void>;
}

import { PaginationParams } from "../../../users/repository/interfaces/IUserRepository";
import { IGymChallenge } from "../../IGymChallenge";
import { CreateGymChallengeParams, IGymChallengeRepository } from "../../repository/interfaces/IGymChallengeRepository";
import { IGymChallengeService } from "../interfaces/IGymChallengeService";

export class GymChallengeService implements IGymChallengeService{
    private gymChallengeRepo:IGymChallengeRepository
    constructor(gymChallengeRepo:IGymChallengeRepository){
        this.gymChallengeRepo = gymChallengeRepo
    }
    save(params: CreateGymChallengeParams): Promise<void> {
        return this.gymChallengeRepo.save(params)
    }
    
    list(paginationParams?: PaginationParams): Promise<IGymChallenge[]>{
        return this.gymChallengeRepo.list(paginationParams)
    }
    
    getById(id: number): Promise<IGymChallenge | null> {
        return this.gymChallengeRepo.getById(id)
    }
    update(id: number, updatedGymChallenge: Partial<CreateGymChallengeParams>): Promise<void> {
        return this.gymChallengeRepo.update(id,updatedGymChallenge)
    }
    delete(id: number): Promise<void> {
        return this.gymChallengeRepo.delete(id)
    }
    
}
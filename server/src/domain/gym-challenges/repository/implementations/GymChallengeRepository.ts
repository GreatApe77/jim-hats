import prisma from "../../../../db/prisma";
import { IGymChallenge } from "../../IGymChallenge";
import { CreateGymChallengeParams, IGymChallengeRepository } from "../interfaces/IGymChallengeRepository";

export class GymChallengeRepository implements IGymChallengeRepository {
    async save(gymChallenge: CreateGymChallengeParams): Promise<void> {
        await prisma.gymChallenge.create({
            data: gymChallenge
        })
    }
    list(): Promise<IGymChallenge[]> {
        throw new Error("Method not implemented.");
    }
    async getById(id: number): Promise<IGymChallenge| null> {
        return prisma.gymChallenge.findUnique({
            where:{
                id
            }
        })
    }
    async update(id: number, updatedGymChallenge: Partial<CreateGymChallengeParams>): Promise<void> {
        await prisma.gymChallenge.update({
            where:{
                id
            },
            data:updatedGymChallenge
        })
    }
    async delete(id: number): Promise<void> {
       await prisma.gymChallenge.delete({
        where:{id}
       })
    }

}
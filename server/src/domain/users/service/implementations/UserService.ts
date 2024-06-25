import { PrismaClientKnownRequestError } from "@prisma/client/runtime/library";
import { HttpError } from "../../../../errors/HttpError";
import { IUser } from "../../IUser";
import { IUserRepository, PaginationParams } from "../../repository/interfaces/IUserRepository";
import { IUserService } from "../interfaces/IUserService";
import { MESSAGES } from "../../../../constants/MESSAGES";



export class UserService implements IUserService{
    private userRepository:IUserRepository
    constructor(userRepository:IUserRepository){
        this.userRepository = userRepository
    }
    async update(id: number, user: Partial<Pick<IUser, "email" | "password" | "profilePicture" | "username">>): Promise<void> {
        try {
            await this.userRepository.update(id,user)
            
        } catch (error) {
            if(error instanceof PrismaClientKnownRequestError){
                if(error.code === 'P2025'){
                    throw new HttpError(404,MESSAGES.USER_NOT_FOUND)
                }
            }
            throw error
        }
    }
    search(prop: string): Promise<IUser | null> {
        if(prop.includes("@")){
            return this.userRepository.findByEmail(prop)
        }
        
        if(!isNaN(parseInt(Number(prop).toString()))){
            
            return this.userRepository.findById(Number(prop))
        }
        
        return this.userRepository.findByUsername(prop)
    }
    list(args?: PaginationParams | Date): Promise<IUser[]> {
        if(args instanceof Date){
            return this.userRepository.findAll(args)
        }
        return this.userRepository.findAll(args)
    }
    async delete(id: number): Promise<void> {
        try {
            await  this.userRepository.delete(id)
            
        } catch (error) {
            if(error instanceof PrismaClientKnownRequestError){
                if(error.code === 'P2025'){
                    throw new HttpError(404,MESSAGES.USER_NOT_FOUND)
                }
            }
            throw error
        }
    }
    
}
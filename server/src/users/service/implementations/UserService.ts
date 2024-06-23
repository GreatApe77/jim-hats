import { IUser } from "../../IUser";
import { IUserRepository, PaginationParams } from "../../repository/interfaces/IUserRepository";
import { IUserService } from "../interfaces/IUserService";



export class UserService implements IUserService{
    private userRepository:IUserRepository
    constructor(userRepository:IUserRepository){
        this.userRepository = userRepository
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
}
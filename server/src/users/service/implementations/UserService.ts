import { IUser } from "../../IUser";
import { IUserRepository } from "../../repository/interfaces/IUserRepository";
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
        
        if(!isNaN(Number(prop))){
            return this.userRepository.findById(Number(prop))
        }
        
        return this.userRepository.findByUsername(prop)
    }
}
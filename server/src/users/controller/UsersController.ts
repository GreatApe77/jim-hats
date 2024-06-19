import { IUserRepository } from "../repository/interfaces/IUserRepository";


export class UsersController {

    usersRepo: IUserRepository;

    constructor(usersRepo: IUserRepository) {
        this.usersRepo = usersRepo;
    }

    

}
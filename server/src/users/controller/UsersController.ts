import { Request, Response } from "express";
import { IUserRepository } from "../repository/interfaces/IUserRepository";
import { IUser } from "../IUser";
import { IUserService } from "../service/interfaces/IUserService";
import { errorResponse, successResponse } from "../../utils/responses";
import { MESSAGES } from "../../constants/MESSAGES";


export class UsersController {

    private userService: IUserService;

    constructor(userService: IUserService) {
        this.userService = userService;
    }

    async handleGetUser(req: Request, res: Response) {
        const id = req.params.id
        try {
            const user = await this.userService.search(id)
            if (!user) {
                return res.status(404).json(errorResponse(MESSAGES.USER_NOT_FOUND))
            }
            
            let {password,...userWithNoPassword} = user
            return res.status(200).json(successResponse(MESSAGES.USER_FOUND,userWithNoPassword    
            ))
        } catch (error) {
            return res.status(500).json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR))
        }

    }

}
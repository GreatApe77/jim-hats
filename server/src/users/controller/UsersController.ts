import { Request, Response } from "express";
import { IUserRepository } from "../repository/interfaces/IUserRepository";
import { IUser } from "../IUser";
import { IUserService } from "../service/interfaces/IUserService";
import { errorResponse, successResponse } from "../../utils/responses";
import { MESSAGES } from "../../constants/MESSAGES";
import { handleErrors } from "../../errors/handleErrors";


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
            return handleErrors(error, res)
        }

    }

    async handleListUsers(req: Request, res: Response) {
        const { date,page,limit } = req.query
        try {
            if (date) {
                const users = await this.userService.list(new Date(date as string))
                return res.status(200).json(successResponse(MESSAGES.USERS_FOUND, users))
            }
            if(page && limit){
                const users = await this.userService.list({offset:parseInt(page as string),limit:parseInt(limit as string)})
                return res.status(200).json(successResponse(MESSAGES.USERS_FOUND, users))
            }
            const users = await this.userService.list()
            return res.status(200).json(successResponse(MESSAGES.USERS_FOUND, users))
        } catch (error) {
            return handleErrors(error, res)
        }
    }

}
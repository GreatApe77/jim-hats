import { Request, Response } from "express";
import { RegisterUserDTO } from "../dto/RegiterUserDTO";
import { IAuthService } from "../services/interfaces/IAuthService";
import { errorResponse, successResponse } from "../../utils/responses";
import { MESSAGES } from "../../constants/MESSAGES";
import { LoginUserDTO } from "../dto/LoginUserDTO";
import { PrismaClientKnownRequestError } from "@prisma/client/runtime/library";

export class AuthController {

    authService: IAuthService;

    constructor(authService: IAuthService) {
        this.authService = authService
    }

    async handleRegister(req: Request, res: Response) {
        const { username, email, password, profilePicture } = req.body as RegisterUserDTO

        try {
            await this.authService.register({ email, password, username, profilePicture })
            return res.status(201).json(successResponse(MESSAGES.REGISTERED_USER))
        } catch (error) {
            if( error instanceof PrismaClientKnownRequestError){
                if(error.code === 'P2002'){
                    return res.status(400).json(errorResponse(MESSAGES.USER_ALREADY_EXISTS))
                }
            }
            return res.status(500).send()

        }
    }


    async handleLogin(req: Request, res: Response) {
        const { username, password } = req.body as LoginUserDTO
        try {
            const jwtToken = await this.authService.login(username, password)
            return res.status(200).json(successResponse(MESSAGES.LOGIN_USER_SUCCESS, { token: jwtToken }))
        } catch (error) {
            console.error(error)
            return res.status(500).json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR))
        }
    }



}
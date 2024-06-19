import { Request, Response } from "express";
import { RegisterUserDTO } from "../dto/RegiterUserDTO";
import { IAuthService } from "../services/interfaces/IAuthService";
import { successResponse } from "../../utils/responses";
import { MESSAGES } from "../../constants/MESSAGES";

export class AuthController {

    authService: IAuthService;

    constructor(authService:IAuthService) {
        this.authService = authService
    }

    async handleRegister(req: Request, res: Response) {
        const { username, email, password, profilePicture } = req.body as RegisterUserDTO

        try {
            await this.authService.register({email,password,username,profilePicture})
            return res.status(201).json(successResponse(MESSAGES.REGISTERED_USER))
        } catch (error) {
            console.error(error)
            return res.status(500).send()
            
        }
    }



}
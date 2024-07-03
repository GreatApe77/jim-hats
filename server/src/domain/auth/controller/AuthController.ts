import { Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES";
import { handleErrors } from "../../../errors/handleErrors";
import { successResponse } from "../../../utils/responses";
import { LoginUserDTO } from "../dto/LoginUserDTO";
import { RegisterUserDTO } from "../dto/RegiterUserDTO";
import { IAuthService } from "../services/interfaces/IAuthService";

export class AuthController {
  authService: IAuthService;

  constructor(authService: IAuthService) {
    this.authService = authService;
  }

  async handleRegister(req: Request, res: Response) {
    const { username, email, password, profilePicture } =
      req.body as RegisterUserDTO;

    try {
      await this.authService.register({
        email,
        password,
        username,
        profilePicture,
      });
      return res.status(201).json(successResponse(MESSAGES.REGISTERED_USER));
    } catch (error) {
      return handleErrors(error, res);
    }
  }

  async handleLogin(req: Request, res: Response) {
    const { username, password } = req.body as LoginUserDTO;
    try {
      const jwtToken = await this.authService.login(username, password);
      return res
        .status(200)
        .json(
          successResponse(MESSAGES.LOGIN_USER_SUCCESS, { token: jwtToken }),
        );
    } catch (error) {
      return handleErrors(error, res);
    }
  }
}

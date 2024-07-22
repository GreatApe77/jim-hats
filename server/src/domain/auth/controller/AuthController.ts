import { Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES.js";
import { handleErrors } from "../../../errors/handleErrors.js";
import { successResponse } from "../../../utils/responses.js";
import { LoginUserDTO } from "../dto/LoginUserDTO.js";
import { RegisterUserDTO } from "../dto/RegiterUserDTO.js";
import { IAuthService } from "../services/interfaces/IAuthService.js";

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

import { NextFunction, Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES";
import { errorResponse } from "../../../utils/responses";
import { RegisterUserSchema } from "../dto/schemas/RegisterUserSchema";
import { LoginUserSchema } from "../dto/schemas/LoginUserSchema";
import { z } from "zod";
import { IAuthService } from "../services/interfaces/IAuthService";
export class AuthMiddleWare {
  authService: IAuthService;
  constructor(authService: IAuthService) {
    this.authService = authService;
  }
  public async onlyAuth(req: Request, res: Response, next: NextFunction) {
    const token = req.headers["authorization"];
    if (!token?.startsWith("Bearer ")) {
      return res
        .status(400)
        .json(errorResponse(MESSAGES.INVALID_JWT_TOKEN_FORMAT));
    }
    const jwtToken = token.split(" ")[1];
    if (!jwtToken) {
      return res.status(400).json(errorResponse(MESSAGES.INVALID_JWT_TOKEN));
    }
    try {
      const userJwtPayload = await this.authService.verifyToken(jwtToken);
      res.locals.authUser = userJwtPayload;

      return next();
    } catch (error) {
      console.log(error);
      return res.status(401).json(errorResponse(MESSAGES.UNAUTHORIZED));
    }
  }
  public validateRegister(req: Request, res: Response, next: NextFunction) {
    try {
      RegisterUserSchema.parse(req.body);
      return next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(422).json(errorResponse(MESSAGES.BAD_REQUEST));
      }
    }
  }
  public validateLogin(req: Request, res: Response, next: NextFunction) {
    try {
      LoginUserSchema.parse(req.body);
      return next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(422).json(errorResponse(MESSAGES.BAD_REQUEST));
      }
    }
  }
}

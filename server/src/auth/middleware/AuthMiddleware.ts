import { NextFunction, Request, Response } from "express";
import { MESSAGES } from "../../constants/MESSAGES";
import { errorResponse } from "../../utils/responses";
import jwt from "jsonwebtoken"
export class AuthMiddleWare {
  public  onlyAuth(req: Request, res: Response, next: NextFunction) {
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
        
    } catch (error) {
        
    }
  }
}

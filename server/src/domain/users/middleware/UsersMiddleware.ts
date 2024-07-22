import { NextFunction, Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES.js";
import { errorResponse } from "../../../utils/responses.js";
import { PatchUserSchema } from "../dto/PatchUserDTO.js";

export class UsersMiddleware {
  validateGetChallengesOfUser(req: Request, res: Response, next: NextFunction) {
    
   
    return next();
  }
  validatePatchUser(req: Request, res: Response, next: NextFunction) {
    try {
      PatchUserSchema.parse(req.body);
      return next();
    } catch (error) {
      return res.status(422).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
  }
  validateGetLogsOfUser(req: Request, res: Response, next: NextFunction) {
    
   
    return next();
  }
  
}

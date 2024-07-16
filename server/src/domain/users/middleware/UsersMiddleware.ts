import { NextFunction, Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES";
import { errorResponse } from "../../../utils/responses";
import { PatchUserSchema } from "../dto/PatchUserDTO";
import { isInt } from "../../../utils/isInt";

export class UsersMiddleware {
  validatePatchUser(req: Request, res: Response, next: NextFunction) {
    try {
      PatchUserSchema.parse(req.body);
      return next();
    } catch (error) {
      return res.status(422).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
  }
  validateGetChallengesOfUser(req: Request, res: Response, next: NextFunction) {
    if(!isInt(req.params.userId)) {
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
    return next();
  }
}

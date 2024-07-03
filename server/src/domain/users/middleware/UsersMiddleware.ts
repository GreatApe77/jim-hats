import { NextFunction, Request, Response } from "express";
import { PatchUserSchema } from "../dto/PatchUserDTO";
import { errorResponse } from "../../../utils/responses";
import { MESSAGES } from "../../../constants/MESSAGES";

export class UsersMiddleware {
  validatePatchUser(req: Request, res: Response, next: NextFunction) {
    try {
      PatchUserSchema.parse(req.body);
      return next();
    } catch (error) {
      return res.status(422).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
  }
}

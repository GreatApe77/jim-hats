import { NextFunction, Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES";
import { isInt } from "../../../utils/isInt";
import { errorResponse } from "../../../utils/responses";
import { CreateGymChallengeSchema } from "../dto/CreateGymChallengeDto";
import { UpdateGymChallengeSchema } from "../dto/UpdateGymChallengeDto";

export class GymChallengeMiddleware {
  validateCreate(req: Request, res: Response, next: NextFunction) {
    try {
      CreateGymChallengeSchema.parse(req.body);
      next();
    } catch (error) {
      console.error(error);
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
  }
  validateUpdate(req: Request, res: Response) {
    try {
      const id = parseInt(req.params.id);
      UpdateGymChallengeSchema.parse({ ...req.body, id });
    } catch (error) {
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
  }
  validateDelete(req: Request, res: Response, next: NextFunction) {
    const id = req.params.id;
    if (!isInt(id)) {
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
    next();
  }
  validateGetById(req: Request, res: Response, next: NextFunction) {
    const id = req.params.id;
    if (!isInt(id)) {
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
    next();
  }
}

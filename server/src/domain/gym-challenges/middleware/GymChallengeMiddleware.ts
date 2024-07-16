import { NextFunction, Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES";
import { isInt } from "../../../utils/isInt";
import { errorResponse } from "../../../utils/responses";
import {
  AddMemberToChallengeParamsSchema,
  AddMemberToChallengeSchema,
} from "../dto/AddMemberToChallengeDto";
import { CreateGymChallengeSchema } from "../dto/CreateGymChallengeDto";
import { UpdateGymChallengeSchema } from "../dto/UpdateGymChallengeDto";
import { AddExerciseLogParamsSchema, AddExerciseLogSchema } from "../dto/AddExerciseLogDto";

export class GymChallengeMiddleware {
  validateAddLog(req: Request, res: Response, next: NextFunction) {
    try {
      
      AddExerciseLogSchema.parse(req.body)
      AddExerciseLogParamsSchema.parse({ challengeId: req.params.challengeId });
      next();
    } catch (error) {
      console.error(error);
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
  }
  validateAddMember(req: Request, res: Response, next: NextFunction) {
    try {
      const challengeId = req.params.challengeId;
      AddMemberToChallengeParamsSchema.parse({ challengeId });
      AddMemberToChallengeSchema.parse(req.body);
      next();
    } catch (error) {
      console.error(error);
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
  }
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
  validateGetMembers(req: Request, res: Response, next: NextFunction) {
    const challengeId = req.params.challengeId;
    if (!isInt(challengeId)) {
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
    next();
  }
}

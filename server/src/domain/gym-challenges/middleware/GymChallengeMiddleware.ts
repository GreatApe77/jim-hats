import { NextFunction, Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES.js";
import { isInt } from "../../../utils/isInt.js";
import { errorResponse } from "../../../utils/responses.js";

import {
  AddExerciseLogParamsSchema,
  AddExerciseLogSchema,
} from "../dto/AddExerciseLogDto.js";
import {
  AddMemberToChallengeParamsSchema,
  AddMemberToChallengeSchema,
} from "../dto/AddMemberToChallengeDto.js";
import { CreateGymChallengeSchema } from "../dto/CreateGymChallengeDto.js";
import { UpdateGymChallengeSchema } from "../dto/UpdateGymChallengeDto.js";
import { JoinChallengeDtoParamsSchema } from "../dto/JoinChallengeDto.js";

export class GymChallengeMiddleware {
  validateJoinChallenge(req: Request, res: Response, next: NextFunction) {
    const joinId = req.params.joinId;
    try {
      JoinChallengeDtoParamsSchema.parse({ joinId });
      return next();
    } catch (error) {
      console.error(error);
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
  }
  validateSearchRanking(req: Request, res: Response, next: NextFunction) {
    const challengeId = req.params.challengeId;
    if (!isInt(challengeId)) {
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
    next();
  }
  validateSearchLogs(req: Request, res: Response, next: NextFunction) {
    const challengeId = req.params.challengeId;
    if (!isInt(challengeId)) {
      return res.status(400).json(errorResponse(MESSAGES.BAD_REQUEST));
    }
    next();
  }
  validateAddLog(req: Request, res: Response, next: NextFunction) {
    try {
      AddExerciseLogSchema.parse(req.body);
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

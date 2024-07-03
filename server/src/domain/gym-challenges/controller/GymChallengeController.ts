import { parse } from "date-fns";
import { Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES";
import { errorResponse, successResponse } from "../../../utils/responses";
import { IFileUploadService } from "../../file-upload/services/interfaces/IFileUploadService";
import { CreateGymChallengeDto } from "../dto/CreateGymChallengeDto";
import { UpdateGymChallengeDto } from "../dto/UpdateGymChallengeDto";
import { IGymChallengeService } from "../service/interfaces/IGymChallengeService";

export class GymChallengeController {
  private gymChallengeService: IGymChallengeService;
  private fileUploadService: IFileUploadService;
  constructor(
    gymChallengeService: IGymChallengeService,
    fileUploadService: IFileUploadService,
  ) {
    this.gymChallengeService = gymChallengeService;
    this.fileUploadService = fileUploadService;
  }

  async save(req: Request, res: Response) {
    try {
      const data = req.body as CreateGymChallengeDto;
      const creatorId = res.locals.authUser.id as number;
      await this.gymChallengeService.save({
        ...data,
        creatorId:creatorId,
        startAt: parse(data.startAt, "dd/MM/yyyy", new Date()),
        endAt: parse(data.endAt, "dd/MM/yyyy", new Date()),
      });
      return res.status(201).json(successResponse(MESSAGES.CREATED));
    } catch (error) {
      console.log(error);
      return res
        .status(500)
        .json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
    }
  }
  async update(req: Request, res: Response) {
    try {
      const id = parseInt(req.params.id);
      const data = req.body as UpdateGymChallengeDto;
      await this.gymChallengeService.update(id, data);
      return res.status(200).json(successResponse(MESSAGES.UPDATED));
    } catch (error) {
      return res
        .status(500)
        .json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
    }
  }

  async getById(req: Request, res: Response) {
    try {
      const id = parseInt(req.params.id);
      const gymChallenge = await this.gymChallengeService.getById(id);
      if (!gymChallenge)
        return res.status(404).json(errorResponse(MESSAGES.NOT_FOUND));
      return res
        .status(200)
        .json(successResponse(MESSAGES.SUCCESS, gymChallenge));
    } catch (error) {
      return res
        .status(500)
        .json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
    }
  }
}

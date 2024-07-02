import { Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES";
import { errorResponse, successResponse } from "../../../utils/responses";
import { IFileUploadService } from "../../file-upload/services/interfaces/IFileUploadService";
import { IGymChallengeService } from "../service/interfaces/IGymChallengeService";
import { CreateGymChallengeDto } from "../dto/CreateGymChallengeDto";

export class GymChallengeController {
  private gymChallengeService: IGymChallengeService;
  private fileUploadService: IFileUploadService;
  constructor(
    gymChallengeService: IGymChallengeService,
    fileUploadService: IFileUploadService
  ) {
    this.gymChallengeService = gymChallengeService;
    this.fileUploadService = fileUploadService;
  }

  async save(req: Request, res: Response) {
    try {
        const data = req.body as CreateGymChallengeDto
        await this.gymChallengeService.save(data)
        return res.status(201).json(successResponse(MESSAGES.CREATED))
    } catch (error) {
      return res
        .status(500)
        .json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
    }
  }
  
}

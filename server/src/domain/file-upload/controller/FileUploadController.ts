import { NextFunction, Request, Response } from "express";
import { IUserService } from "../../users/service/interfaces/IUserService";
import { errorResponse, successResponse } from "../../../utils/responses";
import { MESSAGES } from "../../../constants/MESSAGES";
import { IFileUploadService } from "../services/interfaces/IFileUploadService";
import { DecodedPayload } from "../../auth/services/interfaces/IAuthService";
import { IGymChallengeService } from "../../gym-challenges/service/interfaces/IGymChallengeService";

export class FileUploadController {
  userService: IUserService;
  fileUploadService: IFileUploadService;
  gymChallengeService: IGymChallengeService;
  constructor(
    userService: IUserService,
    fileuploadService: IFileUploadService,
    gymChallengeService: IGymChallengeService,
  ) {
    this.userService = userService;
    this.fileUploadService = fileuploadService;
    this.gymChallengeService = gymChallengeService;
  }
  async handleUploadGymChallengeImage(req: Request, res: Response) {
    const file = req.file;
    if (!file) {
      return res.status(400).json(errorResponse(MESSAGES.INVALID_FILE_TYPE));
    }
    if (!this.validateFileType(file)) {
      return res.status(400).json(errorResponse(MESSAGES.INVALID_FILE_TYPE));
    }
    const authUser = res.locals.authUser as DecodedPayload;
    const id = parseInt(req.params.id);

    const gymChallenge = await this.gymChallengeService.getById(id);
    if (!gymChallenge) {
      return res.status(404).json(errorResponse(MESSAGES.NOT_FOUND));
    }
    if (gymChallenge.creatorId !== authUser.id) {
      return res.status(403).json(errorResponse(MESSAGES.FORBIDDEN));
    }
    try {
      const url = await this.fileUploadService.uploadGymChallengeImage(
        file,
        gymChallenge.id.toString(),
      );
      return res.status(200).json(successResponse(MESSAGES.CREATED, { url }));
    } catch (error) {
      console.log(error);
      return res
        .status(500)
        .json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
    }
  }
  async handleUploadPhotoToProfilePicture(req: Request, res: Response) {
    const file = req.file;
    if (!file) {
      return res.status(400).json(errorResponse(MESSAGES.INVALID_FILE_TYPE));
    }
    if (!this.validateFileType(file)) {
      return res.status(400).json(errorResponse(MESSAGES.INVALID_FILE_TYPE));
    }
    const authUser = res.locals.authUser as DecodedPayload;

    try {
      const url = await this.fileUploadService.uploadProfileImage(
        file,
        authUser.username,
      );
      await this.userService.update(authUser.id, { profilePicture: url });
      return res
        .status(200)
        .json(successResponse(MESSAGES.PROFILE_PICTURE_UPDATED, { url }));
    } catch (error) {
      console.log(error);
      return res
        .status(500)
        .json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
    }
  }
  private validateFileType(file: Express.Multer.File) {
    if (!file) return false;
    return file.mimetype === "image/jpeg" || file.mimetype === "image/png";
  }
}

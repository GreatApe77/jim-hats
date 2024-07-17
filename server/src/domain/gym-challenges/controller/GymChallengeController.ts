import { parse } from "date-fns";
import { Request, Response } from "express";
import { MESSAGES } from "../../../constants/MESSAGES";
import { errorResponse, successResponse } from "../../../utils/responses";
import { IFileUploadService } from "../../file-upload/services/interfaces/IFileUploadService";
import { IUserService } from "../../users/service/interfaces/IUserService";
import { AddExerciseLogDto } from "../dto/AddExerciseLogDto";
import { CreateGymChallengeDto } from "../dto/CreateGymChallengeDto";
import { UpdateGymChallengeDto } from "../dto/UpdateGymChallengeDto";
import { IGymChallengeService } from "../service/interfaces/IGymChallengeService";

export class GymChallengeController {
  private gymChallengeService: IGymChallengeService;
  private fileUploadService: IFileUploadService;
  private usersService: IUserService;
  constructor(
    gymChallengeService: IGymChallengeService,
    fileUploadService: IFileUploadService,
    usersService: IUserService,
  ) {
    this.gymChallengeService = gymChallengeService;
    this.fileUploadService = fileUploadService;
    this.usersService = usersService;
  }

  async save(req: Request, res: Response) {
    try {
      const data = req.body as CreateGymChallengeDto;
      const creatorId = res.locals.authUser.id as number;
      const user = await this.usersService.search(creatorId.toString());
      if (!user) {
        return res.status(404).json(errorResponse(MESSAGES.NOT_FOUND));
      }
      const createdChallenge = await this.gymChallengeService.save({
        ...data,
        creatorId: creatorId,
        startAt: parse(data.startAt, "dd/MM/yyyy", new Date()),
        endAt: parse(data.endAt, "dd/MM/yyyy", new Date()),
      });
      await this.gymChallengeService.addMemberToChallenge(
        createdChallenge.id,
        creatorId,
      );
      return res.status(201).json(
        successResponse(MESSAGES.CREATED, {
          challengeId: createdChallenge.id,
        }),
      );
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
  async getUsersOfChallenge(req: Request, res: Response) {
    try {
      const id = parseInt(req.params.challengeId);
      const users = await this.gymChallengeService.getUsersOfChallenge(id);
      //console.log(users);
      return res.status(200).json(successResponse(MESSAGES.SUCCESS, users));
    } catch (error) {
      console.log(error);
      return res
        .status(500)
        .json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
    }
  }
  async addMemberToChallenge(req: Request, res: Response) {
    try {
      const challengeId = parseInt(req.params.challengeId);
      const { username } = req.body;
      const authUserId = res.locals.authUser.id as number;
      const challenge = await this.gymChallengeService.getById(challengeId);
      if (!challenge) {
        return res.status(404).json(errorResponse(MESSAGES.NOT_FOUND));
      }
      if (challenge.creatorId !== authUserId) {
        return res.status(403).json(errorResponse(MESSAGES.UNAUTHORIZED));
      }
      const newMember = await this.usersService.search(username);
      if (!newMember) {
        return res.status(404).json(errorResponse(MESSAGES.NOT_FOUND));
      }
      await this.gymChallengeService.addMemberToChallenge(
        challengeId,
        newMember.id,
      );
      return res.status(200).json(successResponse(MESSAGES.SUCCESS));
    } catch (error) {
      console.log(error);
      return res
        .status(500)
        .json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
    }
  }

  async addLogToChallenge(req: Request, res: Response) {
    try {
      const challengeId = parseInt(req.params.challengeId);
      const authUserId = res.locals.authUser.id;
      const exerciseLog = req.body as AddExerciseLogDto;
      const challenge = await this.gymChallengeService.getById(challengeId);
      if (!challenge) {
        return res.status(404).json(errorResponse(MESSAGES.NOT_FOUND));
      }
      const now = new Date();
      const isValidTime = now >= challenge.startAt && now <= challenge.endAt;
      if (!isValidTime) {
        return res.status(403).json(errorResponse(MESSAGES.UNAUTHORIZED));
      }
      const usersOfChallenge =await this.gymChallengeService.getUsersOfChallenge(challengeId);
      //console.log(usersOfChallenge)
      //console.log(authUserId)
      const isMember =
        usersOfChallenge.findIndex((user) => user.id === authUserId) !== -1;
        console.log(isMember);
      if (!isMember) {
        return res.status(403).json(errorResponse(MESSAGES.UNAUTHORIZED));
      }
      console.log(exerciseLog);
      const createdLog = await this.gymChallengeService.addLogToChallenge(
        challengeId,
        {
          ...exerciseLog,
          description: exerciseLog.description ? exerciseLog.description : null,
          userId: authUserId,
          date: new Date(),
        },
      );
      return res
        .status(200)
        .json(
          successResponse(MESSAGES.SUCCESS, { createdLogId: createdLog.id }),
        );
    } catch (error) {
      console.log(error);
      return res
        .status(500)
        .json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
    }
  }
  async getLogsGroupedByUser(req: Request, res: Response) {
    try {
      const challengeId = parseInt(req.params.challengeId);
      const authUserId = res.locals.authUser.id;
      const challenge = await this.gymChallengeService.getById(challengeId);
      if (!challenge) {
        return res.status(404).json(errorResponse(MESSAGES.NOT_FOUND));
      }
      const usersOfChallenge =
        await this.gymChallengeService.getUsersOfChallenge(challengeId);
      const isMember =
        usersOfChallenge.findIndex((user) => user.id === authUserId) !== -1;
      if (!isMember) {
        return res.status(403).json(errorResponse(MESSAGES.UNAUTHORIZED));
      }
      const logs = await this.gymChallengeService.getLogsGroupedByUsers(
        challengeId,
      );
      return res.status(200).json(successResponse(MESSAGES.SUCCESS, logs));
    } catch (error) {
      console.log(error);
      return res
        .status(500)
        .json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR));
    }
  }
}

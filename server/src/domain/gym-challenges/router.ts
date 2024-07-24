import { Router } from "express";
import {
  authMiddleware,
  fileUploadService,
  gymChallengeMiddleware,
  gymChallengeService,
  userService,
} from "../../container.js";
import { GymChallengeController } from "./controller/GymChallengeController.js";

const gymChallengesController = new GymChallengeController(
  gymChallengeService,
  fileUploadService,
  userService,
);

const gymChallengesRouter = Router();

gymChallengesRouter.post(
  "/",
  authMiddleware.onlyAuth.bind(authMiddleware),
  gymChallengeMiddleware.validateCreate.bind(gymChallengeMiddleware),
  (req, res) => gymChallengesController.save(req, res),
);
gymChallengesRouter.patch(
  "/:id",
  gymChallengeMiddleware.validateUpdate.bind(gymChallengeMiddleware),
  (req, res) => gymChallengesController.update(req, res),
);
gymChallengesRouter.get(
  "/:id",
  gymChallengeMiddleware.validateGetById.bind(gymChallengeMiddleware),
  (req, res) => gymChallengesController.getById(req, res),
);
gymChallengesRouter.delete(
  "/:id",
  authMiddleware.onlyAuth.bind(authMiddleware),
  gymChallengeMiddleware.validateDelete.bind(gymChallengeMiddleware),
  (req, res) => gymChallengesController.handleChallengeDelete(req, res),
)
gymChallengesRouter.get(
  "/:challengeId/members",
  gymChallengeMiddleware.validateGetMembers.bind(gymChallengeMiddleware),
  (req, res) => gymChallengesController.getUsersOfChallenge(req, res),
);
gymChallengesRouter.post(
  "/:challengeId/members",
  authMiddleware.onlyAuth.bind(authMiddleware),
  gymChallengeMiddleware.validateAddMember.bind(gymChallengeMiddleware),
  (req, res) => gymChallengesController.addMemberToChallenge(req, res),
);
gymChallengesRouter.post(
  "/:challengeId/logs",
  authMiddleware.onlyAuth.bind(authMiddleware),
  gymChallengeMiddleware.validateAddLog.bind(gymChallengeMiddleware),
  (req, res) => gymChallengesController.addLogToChallenge(req, res),
);
gymChallengesRouter.get(
  "/:challengeId/logs",
  authMiddleware.onlyAuth.bind(authMiddleware),
  gymChallengeMiddleware.validateSearchLogs.bind(gymChallengeMiddleware),
  (req, res) => gymChallengesController.getLogsGroupedByUser(req, res),
);
gymChallengesRouter.get(
  "/:challengeId/ranking",
  authMiddleware.onlyAuth.bind(authMiddleware),
  gymChallengeMiddleware.validateSearchRanking.bind(gymChallengeMiddleware),
  (req, res) => gymChallengesController.handleGetRankingOfChallenge(req, res),
);


export { gymChallengesRouter };

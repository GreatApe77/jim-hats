import { Router } from "express";
import {
  authMiddleware,
  fileUploadService,
  gymChallengeMiddleware,
  gymChallengeService,
} from "../../container";
import { GymChallengeController } from "./controller/GymChallengeController";

const gymChallengesController = new GymChallengeController(
  gymChallengeService,
  fileUploadService,
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

export { gymChallengesRouter };

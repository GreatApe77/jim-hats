import { Router } from "express";
import { GymChallengeController } from "./controller/GymChallengeController";
import {
  fileUploadService,
  gymChallengeMiddleware,
  gymChallengeService,
} from "../../container";

const gymChallengesController = new GymChallengeController(
  gymChallengeService,
  fileUploadService,
);

const gymChallengesRouter = Router();

gymChallengesRouter.post(
  "/",
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

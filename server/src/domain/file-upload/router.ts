import { Router } from "express";
import multer from "multer";

import { FileUploadController } from "./controller/FileUploadController";
import {
  authMiddleware,
  fileUploadService,
  gymChallengeService,
  userService,
} from "../../container";

const fileUploadRouter = Router();
const fileUploadController = new FileUploadController(
  userService,
  fileUploadService,
  gymChallengeService,
);
fileUploadRouter.use(multer().single("file"));
fileUploadRouter.post(
  "/profile-picture",
  authMiddleware.onlyAuth.bind(authMiddleware),
  (req, res) =>
    fileUploadController.handleUploadPhotoToProfilePicture(req, res),
);

fileUploadRouter.post(
  "/gym-challenge/:id",
  authMiddleware.onlyAuth.bind(authMiddleware),
  (req, res) => fileUploadController.handleUploadGymChallengeImage(req, res),
);
export { fileUploadRouter };

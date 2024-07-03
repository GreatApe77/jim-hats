import { Router } from "express";
import multer from "multer";

import {
  authMiddleware,
  fileUploadService,
  gymChallengeService,
  userService,
} from "../../container";
import { FileUploadController } from "./controller/FileUploadController";

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
  "/gym-challenges/:id",
  authMiddleware.onlyAuth.bind(authMiddleware),
  (req, res) => fileUploadController.handleUploadGymChallengeImage(req, res),
);
export { fileUploadRouter };

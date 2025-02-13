import { Router } from "express";
import multer from "multer";
import {
  fileUploadService,
  gymChallengeService,
  userService,
} from "../../container.js";
import { FileUploadController } from "./controller/FileUploadController.js";
import { HttpError } from "../../errors/HttpError.js";

const fileUploadRouter = Router();
const fileUploadController = new FileUploadController(
  userService,
  fileUploadService,
  gymChallengeService,
);
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "public/uploads");
  },
  filename: (req, file, cb) => {
    const fileName = `${Date.now()}-${file.originalname}`;
    cb(null, fileName);
    const fullPath = `${process.env.BASE_URL}/uploads/${fileName}`;
    req.body.fullPath = fullPath;
  },
});

const upload = multer({ storage: storage ,
  fileFilter: (req, file, cb) => {
    //png or jpeg
    if (file.mimetype === "image/png" || file.mimetype === "image/jpeg") {
      cb(null, true);
    } else {
      //custom error message how to send in the reponse?
      
      cb(new HttpError(400, `file type ${file.mimetype} is not supported`));
    }
  },
});

const uploadPhoto = upload.single("file");

fileUploadRouter.post(
  "/",
  uploadPhoto,
  (req, res) =>
    fileUploadController.upload(req, res),
);

// fileUploadRouter.post(
//   "/",
//   //authMiddleware.onlyAuth.bind(authMiddleware),
//   (req, res) =>
//     fileUploadController.handleUploadPhotoToProfilePicture(req, res),
// );

// fileUploadRouter.post(
//   "/gym-challenges/:id",
//   authMiddleware.onlyAuth.bind(authMiddleware),
//   (req, res) => fileUploadController.handleUploadGymChallengeImage(req, res),
// );
export { fileUploadRouter };

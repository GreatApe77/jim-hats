import { Router } from "express";
import multer from "multer";
import { HttpError } from "../../errors/HttpError";
import { MESSAGES } from "../../constants/MESSAGES";
import { FileUploadController } from "./controller/FileUploadController";
import { authMiddleware, fileUploadService, userService } from "../../container";

const fileUploadRouter = Router()
const fileUploadController = new FileUploadController(userService,fileUploadService)
fileUploadRouter.use(multer().single("file"))
fileUploadRouter.post("/",
    authMiddleware.onlyAuth.bind(authMiddleware),
    (req,res)=>fileUploadController.handleUploadPhotoToProfilePicture(req,res))


export {
    fileUploadRouter
}
import { NextFunction, Request, Response } from "express";
import { IUserService } from "../../users/service/interfaces/IUserService";
import { errorResponse, successResponse } from "../../../utils/responses";
import { MESSAGES } from "../../../constants/MESSAGES";
import { IFileUploadService } from "../services/interfaces/IFileUploadService";
import { DecodedPayload } from "../../auth/services/interfaces/IAuthService";


export class FileUploadController{
    userService:IUserService
    fileUploadService:IFileUploadService
    constructor(userService:IUserService,fileuploadService:IFileUploadService){
        this.userService = userService
        this.fileUploadService = fileuploadService
    }
    async handleUploadPhotoToProfilePicture(req: Request, res: Response){
        const file = req.file
        if(file?.mimetype !== "image/jpeg" && file?.mimetype !== "image/png"){
            return res.status(400).json(errorResponse(MESSAGES.INVALID_FILE_TYPE))
        }
        if(!file){
            return res.status(400).json(errorResponse(MESSAGES.INVALID_FILE_TYPE))
        }
        const authUser = res.locals.authUser as DecodedPayload

        try {
            const url = await this.fileUploadService.uploadProfileImage(file,authUser.username)
            await this.userService.update(authUser.id,{profilePicture:url})
            return res.status(200).json(successResponse(MESSAGES.PROFILE_PICTURE_UPDATED,{url}))
        } catch (error) {
            console.log(error)
            return res.status(500).json(errorResponse(MESSAGES.INTERNAL_SERVER_ERROR))
        }
    }
}
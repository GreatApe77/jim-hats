import { profilePicturesRef } from "../../../../config/firebase-app";
import { IFileUploadService } from "../interfaces/IFileUploadService";
import {uploadBytes,getDownloadURL} from "firebase/storage"
export class FileUploadService implements IFileUploadService{
    async uploadProfileImage(file: Express.Multer.File, username: string): Promise<string> {
        const uploadResult = await uploadBytes(profilePicturesRef,file.buffer)
        const downloadUrl = await getDownloadURL(uploadResult.ref)
        return downloadUrl
    }

}
import { profilePicturesRef } from "../../../../config/firebase-app";
import { IFileUploadService } from "../interfaces/IFileUploadService";
import { uploadBytes, getDownloadURL, ref } from "firebase/storage"
export class FileUploadService implements IFileUploadService {
    async uploadProfileImage(file: Express.Multer.File, username: string): Promise<string> {
        
        const usernameRef = ref(profilePicturesRef,`${username}.${file.mimetype.split("/")[1]}`)
        const uploadResult = await uploadBytes(usernameRef, file.buffer, {
            contentType: file.mimetype,
            customMetadata: {
                username
            }
        })
        const downloadUrl = await getDownloadURL(uploadResult.ref)
        return downloadUrl
    }

}
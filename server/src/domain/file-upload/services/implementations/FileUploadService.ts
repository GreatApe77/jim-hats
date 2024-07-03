import { getDownloadURL, ref, uploadBytes } from "firebase/storage";
import {
  gymChallengesImagesRef,
  profilePicturesRef,
} from "../../../../config/firebase-app";
import { IFileUploadService } from "../interfaces/IFileUploadService";
export class FileUploadService implements IFileUploadService {
  async uploadGymChallengeImage(
    file: Express.Multer.File,
    fileName: string,
  ): Promise<string> {
    const fileReference = ref(
      gymChallengesImagesRef,
      `${fileName}.${file.mimetype.split("/")[1]}`,
    );
    const uploadResult = await uploadBytes(fileReference, file.buffer, {
      contentType: file.mimetype,
      customMetadata: {
        fileName,
      },
    });
    const downloadUrl = await getDownloadURL(uploadResult.ref);
    return downloadUrl;
  }
  async uploadProfileImage(
    file: Express.Multer.File,
    fileName: string,
  ): Promise<string> {
    const fileReference = ref(
      profilePicturesRef,
      `${fileName}.${file.mimetype.split("/")[1]}`,
    );
    const uploadResult = await uploadBytes(fileReference, file.buffer, {
      contentType: file.mimetype,
      customMetadata: {
        fileName,
      },
    });
    const downloadUrl = await getDownloadURL(uploadResult.ref);
    return downloadUrl;
  }
}

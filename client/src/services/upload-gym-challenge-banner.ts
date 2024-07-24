import { gymChallengesImagesRef, storage } from '@/firebase-app';
import { getDownloadURL, ref, uploadBytes } from 'firebase/storage';
import {v4 as uuidv4} from 'uuid';

export async function uploadGymChallengeBanner(
    bannerImageFile: File
    ): Promise<string> {
    const fileId = uuidv4()
    const fileReference = ref(
        gymChallengesImagesRef,
        `${fileId}.${bannerImageFile.type.split("/")[1]}`
    )
    const uploadResult = await uploadBytes(fileReference, bannerImageFile)
    const fileUrl = await getDownloadURL(uploadResult.ref)
    return fileUrl
}
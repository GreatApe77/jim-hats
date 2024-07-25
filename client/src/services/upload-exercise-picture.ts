import { exerciseLogsImagesRef } from '@/firebase-app';
import { getDownloadURL, ref, uploadBytes } from 'firebase/storage';
import {v4 as uuidv4} from 'uuid';

export async function uploadExercisePic(
    exercisePic: File
    ): Promise<string> {
    const fileId = uuidv4()
    const fileReference = ref(
        exerciseLogsImagesRef,
        `${fileId}.${exercisePic.type.split("/")[1]}`
    )
    const uploadResult = await uploadBytes(fileReference, exercisePic)
    const fileUrl = await getDownloadURL(uploadResult.ref)
    return fileUrl
}
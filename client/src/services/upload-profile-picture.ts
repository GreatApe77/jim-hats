import { profilePicturesRef } from '@/firebase-app';
import { getDownloadURL, ref, uploadBytes } from 'firebase/storage';
import {v4 as uuidv4} from 'uuid';

export async function uploadProfilePicture(
    profilePic: File
    ): Promise<string> {
    const fileId = uuidv4()
    const fileReference = ref(
        profilePicturesRef,
        `${fileId}.${profilePic.type.split("/")[1]}`
    )
    const uploadResult = await uploadBytes(fileReference, profilePic)
    const fileUrl = await getDownloadURL(uploadResult.ref)
    return fileUrl
}

export interface IFileUploadService {
    uploadProfileImage(file:Express.Multer.File,fileName:string):Promise<string>
    
}
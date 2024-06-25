
export interface IFileUploadService {
    uploadProfileImage(file:Express.Multer.File,username:string):Promise<string>
    
}
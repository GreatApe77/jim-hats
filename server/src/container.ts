import { AuthService } from './domain/auth/services/implementations/AuthService';
import { AuthMiddleWare } from './domain/auth/middleware/AuthMiddleware';
import { UserService } from './domain/users/service/implementations/UserService';
import { UserRepository } from './domain/users/repository/implementations/UserRepository';
import { UsersMiddleware } from './domain/users/middleware/UsersMiddleware';
import { FileUploadService } from './domain/file-upload/services/implementations/FileUploadService';


const userRepository = new UserRepository();
const authService = new AuthService(userRepository);
const userService = new UserService(userRepository);
const fileUploadService = new FileUploadService()
const authMiddleware = new AuthMiddleWare(authService);
const usersMiddleware = new UsersMiddleware();

export {
    userRepository,
    authService,
    userService,
    authMiddleware,
    usersMiddleware,
    fileUploadService
}
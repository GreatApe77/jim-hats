import { AuthService } from './domain/auth/services/implementations/AuthService';
import { AuthMiddleWare } from './domain/auth/middleware/AuthMiddleware';
import { UserService } from './domain/users/service/implementations/UserService';
import { UserRepository } from './domain/users/repository/implementations/UserRepository';
import { UsersMiddleware } from './domain/users/middleware/UsersMiddleware';
import { FileUploadService } from './domain/file-upload/services/implementations/FileUploadService';
import { GymChallengeRepository } from './domain/gym-challenges/repository/implementations/GymChallengeRepository';
import { GymChallengeService } from './domain/gym-challenges/service/implementations/GymChallengeService';
import { GymChallengeMiddleware } from './domain/gym-challenges/middleware/GymChallengeMiddleware';


const userRepository = new UserRepository();
const authService = new AuthService(userRepository);
const userService = new UserService(userRepository);
const fileUploadService = new FileUploadService()
const authMiddleware = new AuthMiddleWare(authService);
const usersMiddleware = new UsersMiddleware();
const gymChallengeRepo = new GymChallengeRepository()
const gymChallengeService = new GymChallengeService(gymChallengeRepo)
const gymChallengeMiddleware = new GymChallengeMiddleware()
export {
    userRepository,
    authService,
    userService,
    authMiddleware,
    usersMiddleware,
    fileUploadService,
    gymChallengeRepo,
    gymChallengeService,
    gymChallengeMiddleware
}
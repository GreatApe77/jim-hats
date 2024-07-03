import { AuthMiddleWare } from "./domain/auth/middleware/AuthMiddleware";
import { AuthService } from "./domain/auth/services/implementations/AuthService";
import { FileUploadService } from "./domain/file-upload/services/implementations/FileUploadService";
import { GymChallengeMiddleware } from "./domain/gym-challenges/middleware/GymChallengeMiddleware";
import { GymChallengeRepository } from "./domain/gym-challenges/repository/implementations/GymChallengeRepository";
import { GymChallengeService } from "./domain/gym-challenges/service/implementations/GymChallengeService";
import { UsersMiddleware } from "./domain/users/middleware/UsersMiddleware";
import { UserRepository } from "./domain/users/repository/implementations/UserRepository";
import { UserService } from "./domain/users/service/implementations/UserService";

const userRepository = new UserRepository();
const authService = new AuthService(userRepository);
const userService = new UserService(userRepository);
const fileUploadService = new FileUploadService();
const authMiddleware = new AuthMiddleWare(authService);
const usersMiddleware = new UsersMiddleware();
const gymChallengeRepo = new GymChallengeRepository();
const gymChallengeService = new GymChallengeService(gymChallengeRepo);
const gymChallengeMiddleware = new GymChallengeMiddleware();
export {
  authMiddleware,
  authService,
  fileUploadService,
  gymChallengeMiddleware,
  gymChallengeRepo,
  gymChallengeService,
  userRepository,
  userService,
  usersMiddleware,
};

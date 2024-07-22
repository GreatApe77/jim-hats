import prisma from "./db/prisma.js";
import { AuthMiddleWare } from "./domain/auth/middleware/AuthMiddleware.js";
import { AuthService } from "./domain/auth/services/implementations/AuthService.js";
import { FileUploadService } from "./domain/file-upload/services/implementations/FileUploadService.js";
import { GymChallengeMiddleware } from "./domain/gym-challenges/middleware/GymChallengeMiddleware.js";
import { GymChallengeRepository } from "./domain/gym-challenges/repository/implementations/GymChallengeRepository.js";
import { GymChallengeService } from "./domain/gym-challenges/service/implementations/GymChallengeService.js";
import { UsersMiddleware } from "./domain/users/middleware/UsersMiddleware.js";
import { UserRepository } from "./domain/users/repository/implementations/UserRepository.js";
import { UserService } from "./domain/users/service/implementations/UserService.js";

const userRepository = new UserRepository();
const authService = new AuthService(userRepository);
const userService = new UserService(userRepository,prisma);
const fileUploadService = new FileUploadService();
const authMiddleware = new AuthMiddleWare(authService);
const usersMiddleware = new UsersMiddleware();
const gymChallengeRepo = new GymChallengeRepository();
const gymChallengeService = new GymChallengeService(gymChallengeRepo,prisma);
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

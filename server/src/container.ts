import { AuthService } from './auth/services/implementations/AuthService';
import { AuthMiddleWare } from './auth/middleware/AuthMiddleware';
import { UserService } from './users/service/implementations/UserService';
import { UserRepository } from './users/repository/implementations/UserRepository';


const userRepository = new UserRepository();
const authService = new AuthService(userRepository);
const userService = new UserService(userRepository);

const authMiddleware = new AuthMiddleWare(authService);

export {
    userRepository,
    authService,
    userService,
    authMiddleware
}
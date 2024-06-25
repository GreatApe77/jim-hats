import { AuthService } from './domain/auth/services/implementations/AuthService';
import { AuthMiddleWare } from './domain/auth/middleware/AuthMiddleware';
import { UserService } from './domain/users/service/implementations/UserService';
import { UserRepository } from './domain/users/repository/implementations/UserRepository';


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
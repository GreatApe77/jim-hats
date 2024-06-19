import { AuthService } from "./services/implementations/AuthService";
import userRepo from "../users";
import { AuthController } from "./controller/AuthController";


const authService = new AuthService(userRepo)
const authController = new AuthController(authService)
export {
    authService,
    authController
}


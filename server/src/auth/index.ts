import { AuthService } from "./services/implementations/AuthService";
import {userRepo} from "../users";
import { AuthController } from "./controller/AuthController";
import { AuthMiddleWare } from "./middleware/AuthMiddleware";


const authService = new AuthService(userRepo)
const authController = new AuthController(authService)
const authMiddleWare = new AuthMiddleWare()
export {    
    authService,
    authController,
    authMiddleWare
}


import { AuthService } from "./services/implementations/AuthService";
import userRepo from "../users";


const authService = new AuthService(userRepo)

export default authService


import { UsersController } from "./controller/UsersController";
import { UserRepository } from "./repository/implementations/UserRepository";
import { UserService } from "./service/implementations/UserService";

const userRepo = new UserRepository()
const userService = new UserService(userRepo)
const userController = new UsersController(userService)
export {
    userRepo,
    userService,
    userController
}
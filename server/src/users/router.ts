import { Router } from "express";
import {authMiddleware, userService} from "../container"
import { UsersController } from "./controller/UsersController";
const usersController = new UsersController(userService)
const usersRouter = Router()

usersRouter.get("/:id",(req,res)=>usersController.handleGetUser(req,res))
usersRouter.get("/",(req,res)=>usersController.handleListUsers(req,res))
usersRouter.delete("/:id",authMiddleware.onlyAuth.bind(authMiddleware),(req,res)=>usersController.handleDeleteUser(req,res))
export {
    usersRouter
}
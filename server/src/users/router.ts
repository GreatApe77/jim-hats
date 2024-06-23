import { Router } from "express";
import { userController } from ".";

const usersRouter = Router()

usersRouter.get("/:id",(req,res)=>userController.handleGetUser(req,res))
usersRouter.get("/",(req,res)=>userController.handleListUsers(req,res))
export {
    usersRouter
}
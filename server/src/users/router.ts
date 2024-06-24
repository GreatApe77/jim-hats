import { Router } from "express";
import { userController } from ".";
import { authMiddleWare } from "../auth";

const usersRouter = Router()

usersRouter.get("/:id",(req,res)=>userController.handleGetUser(req,res))
usersRouter.get("/",(req,res)=>userController.handleListUsers(req,res))
usersRouter.delete("/:id",authMiddleWare.onlyAuth,(req,res)=>userController.handleDeleteUser(req,res))
export {
    usersRouter
}
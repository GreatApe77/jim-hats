import { Router } from "express";
import { authController } from ".";

const authRouter = Router()
authRouter.post("/register",(req,res)=>authController.handleRegister(req,res))
authRouter.post("/login",(req,res)=>authController.handleLogin(req,res))
export {
    authRouter
}
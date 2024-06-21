import { Router } from "express";
import { authController, authMiddleWare } from ".";

const authRouter = Router()
authRouter.post("/register", authMiddleWare.validateRegister, (req, res) => authController.handleRegister(req, res))
authRouter.post("/login", authMiddleWare.validateLogin, (req, res) => authController.handleLogin(req, res))
export {
    authRouter
}
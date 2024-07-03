import { Router } from "express";
import { AuthController } from "./controller/AuthController";
import { authService } from "../../container";
import { authMiddleware } from "../../container";
const authController = new AuthController(authService);
const authRouter = Router();
authRouter.post("/register", authMiddleware.validateRegister, (req, res) =>
  authController.handleRegister(req, res),
);
authRouter.post("/login", authMiddleware.validateLogin, (req, res) =>
  authController.handleLogin(req, res),
);
export { authRouter };

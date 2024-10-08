import { Router } from "express";
import { authMiddleware, authService } from "../../container.js";
import { AuthController } from "./controller/AuthController.js";
const authController = new AuthController(authService);
const authRouter = Router();
authRouter.post("/register", authMiddleware.validateRegister, (req, res) =>
  authController.handleRegister(req, res),
);
authRouter.post("/login", authMiddleware.validateLogin, (req, res) =>
  authController.handleLogin(req, res),
);
export { authRouter };

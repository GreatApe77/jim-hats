import { Router } from "express";
import {
  authMiddleware,
  userService,
  usersMiddleware,
} from "../../container.js";
import { UsersController } from "./controller/UsersController.js";
const usersController = new UsersController(userService);
const usersRouter = Router();
usersRouter.get(
  "/me/logs",
  authMiddleware.onlyAuth.bind(authMiddleware),
  usersMiddleware.validateGetLogsOfUser.bind(usersMiddleware),
  (req, res) => usersController.handleGetLogsOfUser(req, res),
);
usersRouter.get(
  "/me",
  authMiddleware.onlyAuth.bind(authMiddleware),
  (req, res) => usersController.handleGetMe(req, res),
);
usersRouter.get("/:id", (req, res) => usersController.handleGetUser(req, res));
usersRouter.get("/", (req, res) => usersController.handleListUsers(req, res));
usersRouter.delete(
  "/:id",
  authMiddleware.onlyAuth.bind(authMiddleware),
  (req, res) => usersController.handleDeleteUser(req, res),
);
usersRouter.patch(
  "/:id",
  usersMiddleware.validatePatchUser.bind(usersMiddleware),

  authMiddleware.onlyAuth.bind(authMiddleware),
  (req, res) => usersController.handleUpdateUser(req, res),
);
usersRouter.get(
  "/:userId/gym-challenges",
  authMiddleware.onlyAuth.bind(authMiddleware),
  usersMiddleware.validateGetChallengesOfUser.bind(usersMiddleware),
  (req, res) => usersController.handleGetChallengesOfUser(req, res),
);

export { usersRouter };

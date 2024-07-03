import { Router } from "express";
import { authRouter } from "./domain/auth/router";
import { fileUploadRouter } from "./domain/file-upload/router";
import { gymChallengesRouter } from "./domain/gym-challenges/router";
import { usersRouter } from "./domain/users/router";

const router = Router();

router.use(authRouter);
router.use("/users", usersRouter);
router.use("/upload", fileUploadRouter);
router.use("/gym-challenges", gymChallengesRouter);
export { router };

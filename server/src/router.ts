import { Router } from "express";
import { authRouter } from "./domain/auth/router.js";
import { fileUploadRouter } from "./domain/file-upload/router.js";
import { gymChallengesRouter } from "./domain/gym-challenges/router.js";
import { usersRouter } from "./domain/users/router.js";

const router = Router();

router.use(authRouter);
router.use("/users", usersRouter);
router.use("/uploads", fileUploadRouter);
router.use("/gym-challenges", gymChallengesRouter);
export { router };

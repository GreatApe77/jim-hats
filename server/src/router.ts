import { Router } from "express";
import { authRouter } from "./domain/auth/router.js";
import { fileUploadRouter } from "./domain/file-upload/router.js";
import { gymChallengesRouter } from "./domain/gym-challenges/router.js";
import { usersRouter } from "./domain/users/router.js";
import { errorResponse } from "./utils/responses.js";

const router = Router();

router.use(authRouter);
router.use("/users", usersRouter);
router.use("/uploads", fileUploadRouter);
router.use("/gym-challenges", gymChallengesRouter);
router.get("/health", (req, res) => {
    return res.status(200).json({ message: "OK" });
})
router.use("*",(req,res)=>{
    return res.status(404).send(errorResponse("Route not found"))
})
export { router };

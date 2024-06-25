import { Router } from "express";
import { authRouter } from "./domain/auth/router";
import { usersRouter } from "./domain/users/router";
import { fileUploadRouter } from "./domain/file-upload/router";


const router = Router()

router.use(authRouter)
router.use("/users", usersRouter)
router.use("/upload",fileUploadRouter)
export {
    router
}
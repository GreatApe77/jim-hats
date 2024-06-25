import { Router } from "express";
import { authRouter } from "./domain/auth/router";
import { usersRouter } from "./domain/users/router";


const router = Router()

router.use(authRouter)
router.use("/users", usersRouter)
export {
    router
}
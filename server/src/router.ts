import { Router } from "express";
import { authRouter } from "./auth/router";
import { usersRouter } from "./users/router";


const router = Router()

router.use(authRouter)
router.use("/users",usersRouter)
export {
    router
}
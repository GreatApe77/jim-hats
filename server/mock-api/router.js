import { Router } from "express";
import { healthController } from "./controllers/health.js";
import { register } from "./controllers/register.js";
import { login } from "./controllers/login.js";
import { listChallengesOfUser } from "./controllers/list-challenges-of-user.js";
import { listMembersOfChallenge } from "./controllers/list-members-of-challenge.js";
import { listLogsOfChallenge } from "./controllers/list-logs-of-challenge.js";
import { listRankingOfChallenge } from "./controllers/list-ranking-of-challenge.js";
import { uploadController, uploadPhoto } from "./controllers/upload.js";
import { errorResponse } from "./utils/error-response.js";
import { joinChallenge } from "./controllers/join-challenge.js";
import { createGymChallenge } from "./controllers/create-gym-challenge.js";

const router = Router();

router.get("/health",healthController);
router.post("/register",register);
router.post("/login",login);
router.get("/users/:userId/gym-challenges", listChallengesOfUser)
router.get("/gym-challenges/:challengeId/members",listMembersOfChallenge)
router.get("/gym-challenges/:challengeId/logs",listLogsOfChallenge)
router.get("/gym-challenges/:challengeId/ranking",listRankingOfChallenge)
router.get("/gym-challenges/:joinId/join",joinChallenge)
router.post("/gym-challenges/",createGymChallenge)
router.post("/uploads",uploadPhoto,uploadController)



////404
router.use("*",(req,res)=>{
    return res.status(404).send(errorResponse("Route not found"))
})
///

export {router}
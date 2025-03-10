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
import { updateGymChallenge } from "./controllers/update-gym-challenge.js";
import { deleteGymChallenge } from "./controllers/delete-gym-challenge.js";
import { addLogToGymChallenge } from "./controllers/add-log-to-gym-challenge.js";
import { listAllLogsOfUser } from "./controllers/list-all-logs-of-user.js";
import { getMe } from "./controllers/get-me.js";
import { updateUser } from "./controllers/update-user.js";
import { updateExerciseLog } from "./controllers/update-exercise-log.js";
import { deleteExerciseLog } from "./controllers/delete-exercise-log.js";

const router = Router();

router.get("/health",healthController);
router.post("/register",register);
router.post("/login",login);
router.get("/users/me/logs",listAllLogsOfUser)
router.get("/users/me",getMe)
router.patch("/users/me",updateUser)
router.get("/users/:userId/gym-challenges", listChallengesOfUser)
router.get("/gym-challenges/:challengeId/members",listMembersOfChallenge)
router.get("/gym-challenges/:challengeId/logs",listLogsOfChallenge)
router.get("/gym-challenges/:challengeId/ranking",listRankingOfChallenge)
router.get("/gym-challenges/:joinId/join",joinChallenge)
router.post("/gym-challenges/",createGymChallenge)
router.patch("/gym-challenges/:id",updateGymChallenge)
router.delete("/gym-challenges/:id",deleteGymChallenge)
router.post("/gym-challenges/:challengeId/logs",addLogToGymChallenge)
router.patch("/logs/:logId",updateExerciseLog)
router.delete("/logs/:logId",deleteExerciseLog)
router.post("/uploads",uploadPhoto,uploadController)



////404
router.use("*",(req,res)=>{
    return res.status(404).send(errorResponse("Route not found"))
})
///

export {router}
import { successResponse } from "../utils/success-response";
import { MESSAGES } from "../messages";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function getMe(req, res) {
   console.log(req.headers["authorization"])
   const user ={
     'username': 'Mateus',
     'id': 4,
     'email': 'mateus@gmail.com',
     'profilePicture': 'https://avatars.githubusercontent.com/u/67892495?s=200&v=4'
   }
   return res.status(200).json(successResponse(MESSAGES.USER_FOUND,user))
}
import { successResponse } from "../utils/success-response";
import { MESSAGES } from "../messages";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function register(req, res) {
 const { username, email, password, profilePicture } = req.body;
   console.log(req.body)
   // Mock response for user registration
   return res.status(201).json(successResponse(MESSAGES.REGISTERED_USER));
}
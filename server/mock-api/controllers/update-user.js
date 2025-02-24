import { successResponse } from "../utils/success-response.js";
import { MESSAGES } from "../messages.js";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function updateUser(req, res) {
    const { profilePicture } = req.body;
    console.log(req.body);
   return res.status(200).json(successResponse(MESSAGES.SUCCESS));
}
import { successResponse } from "../utils/success-response.js";
import { MESSAGES } from "../messages.js";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function joinChallenge(req, res) {
 //const { username, password } = req.body;
    const joinId = req.params.joinId;
   return res.status(200).json(successResponse(MESSAGES.SUCCESS));
}
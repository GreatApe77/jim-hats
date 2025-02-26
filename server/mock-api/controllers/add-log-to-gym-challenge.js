import { successResponse } from "../utils/success-response.js";
import { MESSAGES } from "../messages.js";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function addLogToGymChallenge(req, res) {
   //
   //
   // description: z.string().optional(),
   //   title: z.string(),
   //   image: z.string().url(),
   const { description, title, image } = req.body;
   console.log(req.body);
   return res.status(201).json(successResponse(MESSAGES.SUCCESS));
}
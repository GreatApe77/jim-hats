import { successResponse } from "../utils/success-response.js";
import { MESSAGES } from "../messages.js";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function createGymChallenge(req, res) {
    // name: z.string(),
    // description: z.string(),
    // image: z.string().url().nullable(),
    // startAt: z.string().refine(dateInFutureOrPresent),
    // endAt: z.string().refine(dateInFutureOrPresent),
    const { name, description, image, startAt, endAt } = req.body;
    console.log(req.body);
   return res.status(201).json(successResponse(MESSAGES.SUCCESS));
}
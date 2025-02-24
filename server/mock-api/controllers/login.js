import { successResponse } from "../utils/success-response";
import { MESSAGES } from "../messages";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function login(req, res) {
 const { username, password } = req.body;
   // Mock login response with a JWT token
   const jwtToken = "mocked_jwt_token";
   return res.status(200).json(successResponse(MESSAGES.LOGIN_USER_SUCCESS, { token: jwtToken }));
}
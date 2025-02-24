import { successResponse } from "../utils/success-response.js";
import { MESSAGES } from "../messages.js";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function listAllLogsOfUser(req, res) {
   //
   //    const logs: {
   //       id: number;
   //       title: string;
   //       description: string | null;
   //       image: string | null;
   //       date: Date;
   //       userId: number;
   //       gymChallengeId: number;
   //   }[]
   const logs = Array.from({ length: 24 }, (_, i) => ({
      id: i + 1,
      title: `Exercise Log ${i + 1}`,
      description: Math.random() > 0.3 ? `Description for log ${i + 1}` : null,
      image: Math.random() > 0.5 ? `https://example.com/image${i + 1}.jpg` : null,
      date: Date.now() - Math.floor(Math.random() * 10000000000), // Data no passado
      userId: res.locals.authUser?.id ?? 1, // Usuário fictício (1 a 10)
      gymChallengeId: Math.floor(Math.random() * 5) + 1, // Desafio fictício (1 a 5)
   }));
   const { description, title, image } = req.body;
   console.log(req.body);
   return res.status(201).json(successResponse(MESSAGES.SUCCESS,logs));
}
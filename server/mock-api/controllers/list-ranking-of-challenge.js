import { successResponse } from "../utils/success-response.js";
import { MESSAGES } from "../messages.js";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function listRankingOfChallenge(req, res) {
const rankings = [
    {
      id: 1,
      username: 'User1',
      profilePicture: 'https://url.com/',
      logCount: 10
    },
    {
      id: 2,
      username: 'User2',
      profilePicture: 'https://url.com/',
      logCount: 9
    },
    {
      id: 3,
      username: 'User3',
      profilePicture: 'https://url.com/',
      logCount: 8
    },
    {
      id: 4,
      username: 'User4',
      profilePicture: null,
      logCount: 7
    },
    {
      id: 5,
      username: 'User5',
      profilePicture: null,
      logCount: 6
    },
    {
      id: 6,
      username: 'User6',
      profilePicture: 'https://url.com/',
      logCount: 5
    },
    {
      id: 7,
      username: 'User7',
      profilePicture: 'https://url.com/',
      logCount: 4
    },
    {
      id: 8,
      username: 'User8',
      profilePicture: null,
      logCount: 3
    }
  ];
  return res.status(200).json(successResponse(MESSAGES.SUCCESS,rankings))
}
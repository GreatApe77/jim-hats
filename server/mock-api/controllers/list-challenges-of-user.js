import { successResponse } from "../utils/success-response";
import { MESSAGES } from "../messages";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function listChallengesOfUser(req, res) {
    const gymChallenges = [
        {
          id: 5,
          name: 'Challenge 5',
          description: 'Challenge Description 5',
          image: 'https://avatars.githubusercontent.com/u/97452495?s=200&v=4',
          joinId: null,
          createdAt: new Date().getTime(),
          startAt: new Date('2024-01-01T00:00:00Z').getTime(),
          endAt: new Date('2027-01-01T00:00:00Z').getTime(),
          creatorId: 1
        },
        {
          id: 6,
          name: 'Challenge 6',
          description: 'Challenge Description 6',
          image: 'https://avatars.githubusercontent.com/u/98452395?s=200&v=4',
          joinId: null,
          createdAt: new Date().getTime(),
          startAt: new Date(Date.now() + 20000000).getTime(),
          endAt: new Date(Date.now() + 80000000).getTime(),
          creatorId: 1
        },
        {
          id: 7,
          name: 'Challenge 7',
          description: 'Challenge Description 7',
          image: null,
          joinId: null,
          createdAt: new Date().getTime(),
          startAt: new Date(Date.now() + 20000000).getTime(),
          endAt: new Date(Date.now() + 80000000).getTime(),
          creatorId: 1
        }
      ];
 return res.status(200).json(successResponse(MESSAGES.SUCCESS,gymChallenges));
}
import { successResponse } from "../utils/success-response.js";
import { MESSAGES } from "../messages.js";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function listMembersOfChallenge(req, res) {
  const challengeMembers =  [
    {
      id: 1,
      username: 'user1',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892495?s=200&v=4'
    },
    {
      id: 2,
      username: 'user2',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892395?s=200&v=4'
    },
    {
      id: 3,
      username: 'user3',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892494?s=200&v=4'
    },
    {
      id: 4,
      username: 'user4',
      profilePicture: 'https://avatars.githubusercontent.com/u/97892495?s=200&v=4'
    },
    {
      id: 5,
      username: 'user5',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892595?s=200&v=4'
    },
    {
      id: 6,
      username: 'user6',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892495?s=200&v=4'
    },
    {
      id: 7,
      username: 'user7',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892395?s=200&v=4'
    },
    {
      id: 8,
      username: 'user8',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892494?s=200&v=4'
    },
    {
      id: 9,
      username: 'user9',
      profilePicture: 'https://avatars.githubusercontent.com/u/97892495?s=200&v=4'
    },
    {
      id: 10,
      username: 'user10',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892595?s=200&v=4'
    },
    {
      id: 11,
      username: 'user11',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892495?s=200&v=4'
    },
    {
      id: 12,
      username: 'user12',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892395?s=200&v=4'
    },
    {
      id: 13,
      username: 'user13',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892494?s=200&v=4'
    },
    {
      id: 14,
      username: 'user14',
      profilePicture: 'https://avatars.githubusercontent.com/u/97892495?s=200&v=4'
    },
    {
      id: 15,
      username: 'user15',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892595?s=200&v=4'
    }
  ];
  return res.status(200).json(successResponse(MESSAGES.SUCCESS,challengeMembers))
}
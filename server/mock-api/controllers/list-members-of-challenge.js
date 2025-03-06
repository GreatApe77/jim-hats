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
      username: 'Claude',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892495?s=200&v=4'
    },
    {
      id: 2,
      username: 'Marcos',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892395?s=200&v=4'
    },
    {
      id: 3,
      username: 'John',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892494?s=200&v=4'
    },
    {
      id: 4,
      username: 'Marston',
      profilePicture: 'https://avatars.githubusercontent.com/u/97892495?s=200&v=4'
    },
    {
      id: 5,
      username: 'Carlos',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892595?s=200&v=4'
    },
    {
      id: 6,
      username: 'Logan',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892495?s=200&v=4'
    },
    {
      id: 7,
      username: 'Matheus',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892395?s=200&v=4'
    },
    {
      id: 8,
      username: 'Nicolas',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892494?s=200&v=4'
    },
    {
      id: 9,
      username: 'Anonimo',
      profilePicture: null
    },
    {
      id: 10,
      username: 'Joao',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892595?s=200&v=4'
    },
    {
      id: 11,
      username: 'Maria',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892495?s=200&v=4'
    },
    {
      id: 12,
      username: 'Fernanda',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892395?s=200&v=4'
    },
    {
      id: 13,
      username: 'Pedro',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892494?s=200&v=4'
    },
    {
      id: 14,
      username: 'user14',
      profilePicture: null
    },
    {
      id: 15,
      username: 'user15',
      profilePicture: 'https://avatars.githubusercontent.com/u/99892595?s=200&v=4'
    }
  ];
  return res.status(200).json(successResponse(MESSAGES.SUCCESS,challengeMembers))
}
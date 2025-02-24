import { successResponse } from "../utils/success-response.js";
import { MESSAGES } from "../messages.js";
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function listLogsOfChallenge(req, res) {
    const dayInMilliseconds = 8.64 * Math.pow(10, 7);
    const challengeId = Number(req.params.challengeId)
    const exerciseLogs = [
        {
            id: 1,
            title: 'Morning Run',
            description: '5km run in the park',
            image: null,
            date: Date.now() - dayInMilliseconds * 13,
            userId: 1,
            gymChallengeId: challengeId,
            user: {
                username: 'john_doe',
                profilePicture: null
            }
        },
        {
            id: 2,
            title: 'Weight Lifting',
            description: 'Chest and triceps workout',
            image: null,
            date: Date.now() - dayInMilliseconds * 12,
            userId: 2,
            gymChallengeId: challengeId,
            user: {
                username: 'jane_smith',
                profilePicture: null
            }
        },
        {
            id: 3,
            title: 'Yoga Session',
            description: '1-hour yoga class',
            image: 'https://avatars.githubusercontent.com/u/99892495?s=200&v=4',
            date: Date.now() - dayInMilliseconds * 11,
            userId: 3,
            gymChallengeId: challengeId,
            user: {
                username: 'alice_jones',
                profilePicture: 'https://avatars.githubusercontent.com/u/99892395?s=200&v=4'
            }
        },
        {
            id: 4,
            title: 'Cycling',
            description: '20km cycling route',
            image: 'https://avatars.githubusercontent.com/u/99892494?s=200&v=4',
            date: Date.now() - dayInMilliseconds * 10,
            userId: 4,
            gymChallengeId: challengeId,
            user: {
                username: 'bob_brown',
                profilePicture: 'https://avatars.githubusercontent.com/u/97892495?s=200&v=4'
            }
        },
        {
            id: 5,
            title: 'Swimming',
            description: '30 minutes of swimming',
            image: null,
            date: Date.now() - dayInMilliseconds * 10,
            userId: 5,
            gymChallengeId: challengeId,
            user: {
                username: 'charlie_davis',
                profilePicture: 'https://avatars.githubusercontent.com/u/99892595?s=200&v=4'
            }
        },
        {
            id: 6,
            title: 'HIIT Workout',
            description: 'High-intensity interval training',
            image: 'https://avatars.githubusercontent.com/u/99892494?s=200&v=4',
            date: Date.now() - dayInMilliseconds,
            userId: 6,
            gymChallengeId: challengeId,
            user: {
                username: 'diana_evans',
                profilePicture: null
            }
        },
        {
            id: 7,
            title: 'Pilates',
            description: 'Pilates class',
            image: null,
            date: Date.now() - dayInMilliseconds,
            userId: 7,
            gymChallengeId: challengeId,
            user: {
                username: 'frank_green',
                profilePicture: null
            }
        },
        {
            id: 8,
            title: 'Boxing',
            description: 'Boxing training session',
            image: null,
            date: Date.now(),
            userId: 8,
            gymChallengeId: challengeId,
            user: {
                username: 'george_hill',
                profilePicture: null
            }
        },
        {
            id: 9,
            title: 'Dance Class',
            description: 'Zumba dance class',
            image: null,
            date: Date.now(),
            userId: 9,
            gymChallengeId: challengeId,
            user: {
                username: 'hannah_lee',
                profilePicture: null
            }
        },
        {
            id: 10,
            title: 'Rock Climbing',
            description: 'Indoor rock climbing session',
            image: null,
            date: Date.now(),
            userId: 10,
            gymChallengeId: challengeId,
            user: {
                username: 'ian_martin',
                profilePicture: null
            }
        }
    ];
    return res.status(200).json(successResponse(MESSAGES.SUCCESS, exerciseLogs))
}
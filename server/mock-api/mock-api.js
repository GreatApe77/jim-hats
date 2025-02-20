/* eslint-disable no-undef */
/* eslint-disable @typescript-eslint/no-unused-vars */
import express from "express";
import morgan from "morgan";
import multer from "multer";
import "dotenv/config";
const app = express();
app.use(morgan("tiny"));
app.use(express.json());

// MESSAGES Object
export const MESSAGES = {
  INVALID_JWT_TOKEN_FORMAT: "Invalid JWT token format. Format should be 'Bearer <token>'",
  INVALID_JWT_TOKEN: "Invalid JWT",
  REGISTERED_USER: "Registered user",
  LOGIN_USER_SUCCESS: "Logged in",
  INTERNAL_SERVER_ERROR: "Internal server error",
  USER_NOT_FOUND: "User not found",
  USER_FOUND: "User found",
  INVALID_USERNAME: "Username cannot contain spaces or @ symbol",
  BAD_REQUEST: "Bad request",
  USERS_FOUND: "Users found",
  USER_ALREADY_EXISTS: "User already exists",
  WRONG_PASSWORD: "Wrong password",
  UNAUTHORIZED: "Unauthorized",
  USER_DELETED: "User deleted",
  USER_UPDATED: "User updated",
  PROFILE_PICTURE_UPDATED: "Profile picture updated",
  INVALID_FILE_TYPE: "Profile picture should be a jpeg or png file",
  CREATED: "Created",
  UPDATED: "Updated",
  SUCCESS: "Success",
  NOT_FOUND: "Not found",
  FORBIDDEN: "Forbidden",
  DELETED: "Deleted"
};

// Helper function for success responses
const successResponse = (message, data = null) => {
  return {
    status: "success",
    message: message,
    data: data
  };
};

// Helper function for error responses
const errorResponse = (message) => {
  return {
    status: "error",
    message: message
  };
};
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "public/uploads");
  },
  filename: (req, file, cb) => {
    const fileName = `${Date.now()}-${file.originalname}`;
    cb(null, fileName);
    const fullPath = `${process.env.BASE_URL}/uploads/${fileName}`;
    req.body.fullPath = fullPath;
  },
});

const upload = multer({ storage: storage ,
  fileFilter: (req, file, cb) => {
    //png or jpeg
    if (file.mimetype === "image/png" || file.mimetype === "image/jpeg") {
      cb(null, true);
    } else {
      //custom error message how to send in the reponse?
      
      cb(new Error(`file type ${file.mimetype} is not supported`));
    }
  },
});

const uploadPhoto = upload.single("file");

app.use(express.static("public"))
app.get("/users/me/logs",(req,res)=>{

})

app.get("/users/me",(req,res)=>{
  console.log(req.headers["authorization"])
  const user ={
    'username': 'Mateus',
    'id': 4,
    'email': 'mateus@gmail.com',
    'profilePicture': 'https://avatars.githubusercontent.com/u/67892495?s=200&v=4'
  }
  return res.status(200).json(successResponse(MESSAGES.USER_FOUND,{user:user}))
})
app.get(
  "/users/:userId/gym-challenges",(req,res)=>{
    const gymChallenges = [
      {
        id: 5,
        name: 'Challenge 5',
        description: 'Challenge Description 5',
        image: 'https://avatars.githubusercontent.com/u/97452495?s=200&v=4',
        joinId: null,
        createdAt: new Date(),
        startAt: new Date('2024-01-01T00:00:00Z'),
        endAt: new Date('2027-01-01T00:00:00Z'),
        creatorId: 1
      },
      {
        id: 6,
        name: 'Challenge 6',
        description: 'Challenge Description 6',
        image: 'https://avatars.githubusercontent.com/u/98452395?s=200&v=4',
        joinId: null,
        createdAt: new Date(),
        startAt: new Date(Date.now() + 20000000),
        endAt: new Date(Date.now() + 80000000),
        creatorId: 1
      },
      {
        id: 7,
        name: 'Challenge 7',
        description: 'Challenge Description 7',
        image: null,
        joinId: null,
        createdAt: new Date(),
        startAt: new Date(Date.now() + 20000000),
        endAt: new Date(Date.now() + 80000000),
        creatorId: 1
      }
    ];
    return res.status(200).json(gymChallenges)
  }
)
app.get("/gym-challenges/:challengeId/logs",(req,res)=>{
  const dayInMilliseconds = 8.64 * Math.pow(10, 7);
const challengeId = req.params.challengeId
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
return res.status(200).json(exerciseLogs)
})
app.get("/gym-challenges/:challengeId/ranking",(req,res)=>{
  const rankings = [
    {
      id: 1,
      username: 'User1',
      profilePicture: 'url1',
      logCount: 10
    },
    {
      id: 2,
      username: 'User2',
      profilePicture: 'url2',
      logCount: 9
    },
    {
      id: 3,
      username: 'User3',
      profilePicture: 'url3',
      logCount: 8
    },
    {
      id: 4,
      username: 'User4',
      profilePicture: 'url4',
      logCount: 7
    },
    {
      id: 5,
      username: 'User5',
      profilePicture: 'url5',
      logCount: 6
    },
    {
      id: 6,
      username: 'User6',
      profilePicture: 'url6',
      logCount: 5
    },
    {
      id: 7,
      username: 'User7',
      profilePicture: 'url7',
      logCount: 4
    },
    {
      id: 8,
      username: 'User8',
      profilePicture: 'url8',
      logCount: 3
    }
  ];
  return res.status(200).json(rankings)
})
app.post("/uploads",uploadPhoto,(req,res)=>{
  const fullPath= req.body.fullPath
  return res.status(200).json(successResponse(MESSAGES.CREATED,{fullPath}))
})
// Route to register a user
app.post("/register", (req, res) => {
  const { username, email, password, profilePicture } = req.body;
  console.log(req.body)
  // Mock response for user registration
  return res.status(201).json(successResponse(MESSAGES.REGISTERED_USER));
});

// Route to log in a user
app.post("/login", (req, res) => {
  const { username, password } = req.body;
  // Mock login response with a JWT token
  const jwtToken = "mocked_jwt_token";
  return res.status(200).json(successResponse(MESSAGES.LOGIN_USER_SUCCESS, { token: jwtToken }));
});

// Route to join a gym challenge
app.get("/gym-challenge/join/:joinId", (req, res) => {
  const joinId = req.params.joinId;
  const authUserId = 1; // Mock authenticated user ID

  // Mock gym challenge join response
  return res.status(201).json(successResponse(MESSAGES.SUCCESS));
});

// Route to delete a gym challenge
app.delete("/gym-challenge/:id", (req, res) => {
  const id = req.params.id;
  const authUserId = 1; // Mock authenticated user ID

  // Mock gym challenge delete response
  return res.status(200).json(successResponse(MESSAGES.DELETED));
});

// Route to get ranking of a gym challenge
app.get("/gym-challenge/ranking/:challengeId", (req, res) => {
  const challengeId = req.params.challengeId;

  // Mock gym challenge ranking response
  const ranking = [
    { userId: 1, points: 100 },
    { userId: 2, points: 90 }
  ];

  return res.status(200).json(successResponse(MESSAGES.SUCCESS, ranking));
});

// Route to get users in a gym challenge
app.get("/gym-challenge/:challengeId/users", (req, res) => {
  const challengeId = req.params.challengeId;

  // Mock users in a gym challenge response
  const users = [
    { id: 1, username: "user1" },
    { id: 2, username: "user2" }
  ];

  return res.status(200).json(successResponse(MESSAGES.SUCCESS, users));
});

// New Route to add an exercise log to a gym challenge
app.post("/gym-challenge/:challengeId/logs", (req, res) => {
  const challengeId = req.params.challengeId;
  const { exerciseId, date, duration, repetitions, sets } = req.body;

  // Mock response for adding an exercise log
  const newLog = {
    exerciseId,
    date,
    duration,
    repetitions,
    sets
  };

  return res.status(201).json(successResponse(MESSAGES.CREATED, newLog));
});

// New Route to get logs for a specific gym challenge
app.get("/gym-challenge/:challengeId/logs", (req, res) => {
  const challengeId = req.params.challengeId;

  // Mock response for getting exercise logs of a gym challenge
  const logs = [
    { logId: 1, exerciseId: "squat", date: "2025-02-17", duration: 30, repetitions: 20, sets: 3 },
    { logId: 2, exerciseId: "bench_press", date: "2025-02-17", duration: 25, repetitions: 15, sets: 3 }
  ];

  return res.status(200).json(successResponse(MESSAGES.SUCCESS, logs));
});

// New Route to delete an exercise log from a gym challenge
app.delete("/gym-challenge/:challengeId/logs/:logId", (req, res) => {
  const { challengeId, logId } = req.params;

  // Mock response for deleting an exercise log
  return res.status(200).json(successResponse(MESSAGES.DELETED));
});
// Route to check the health of the API
app.get("/health", (req, res) => {
    return res.status(200).json(successResponse(MESSAGES.SUCCESS, { status: "API is running" }));
  });
// Start the server
app.listen(3000, () => {
  
  console.log("Mock API server running on port 3000");
});

/* eslint-disable no-undef */
/* eslint-disable @typescript-eslint/no-unused-vars */
import express from "express";
import morgan from "morgan";
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

// Route to register a user
app.post("/register", (req, res) => {
  const { username, email, password, profilePicture } = req.body;
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

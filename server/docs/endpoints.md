# API Endpoints Documentation

## **Authentication (`/`)**
- `POST /register` → Register a new user  
- `POST /login` → Login  

---

## **Users (`/users`)**
- `GET /users` → List all users  
- `GET /users/:id` → Get a specific user by ID  
- `GET /users/me` → Get the authenticated user’s profile  
- `GET /users/me/logs` → Get exercise logs of the authenticated user  
- `PATCH /users/:id` → Update user information  
- `DELETE /users/:id` → Delete a user  
- `GET /users/:userId/gym-challenges` → Get gym challenges of a specific user  

---

## **File Uploads (`/uploads`)**
- `POST /uploads/profile-picture` → Upload profile picture (authenticated)  
- `POST /uploads/gym-challenges/:id` → Upload an image for a gym challenge (authenticated)  

---

## **Gym Challenges (`/gym-challenges`)**
- `POST /gym-challenges/` → Create a new gym challenge (authenticated)  
- `PATCH /gym-challenges/:id` → Update a gym challenge  
- `GET /gym-challenges/:id` → Get details of a specific gym challenge (authenticated)  
- `DELETE /gym-challenges/:id` → Delete a gym challenge (authenticated)  
- `GET /gym-challenges/:joinId/join` → Join a gym challenge (authenticated)  
- `GET /gym-challenges/:challengeId/members` → Get members of a gym challenge  
- `POST /gym-challenges/:challengeId/members` → Add a member to a gym challenge (authenticated)  
- `POST /gym-challenges/:challengeId/logs` → Add a log to a gym challenge (authenticated)  
- `GET /gym-challenges/:challengeId/logs` → Get logs grouped by user for a gym challenge (authenticated)  
- `GET /gym-challenges/:challengeId/ranking` → Get ranking for a gym challenge (authenticated)  

---

## **Health Check (`/health`)**
- `GET /health` → Check if the API is running  

---

## **404 Not Found (`*`)**
- `ANY /*` → Catch-all route for undefined routes  


# API Endpoints Documentation

## **Authentication**
Base path: `/`

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| POST | `/register` | Register a new user | No |
| POST | `/login` | Login and receive an authentication token | No |

---

## **Users**
Base path: `/users`

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| GET | `/` | List all users | No |
| GET | `/me` | Get the authenticated user's profile | Yes |
| GET | `/me/logs` | Get exercise logs of the authenticated user | Yes |
| GET | `/:id` | Get a specific user by ID | No |
| PATCH | `/me` | Update the authenticated user's information | Yes |
| DELETE | `/:id` | Delete a user | Yes |
| GET | `/:userId/gym-challenges` | Get gym challenges of a specific user | Yes |

---

## **File Uploads**
Base path: `/uploads`

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| POST | `/` | Upload an image file (PNG/JPEG) | No |

---

## **Gym Challenges**
Base path: `/gym-challenges`

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| POST | `/` | Create a new gym challenge | Yes |
| GET | `/:id` | Get details of a specific gym challenge | Yes |
| PATCH | `/:id` | Update a gym challenge | No |
| DELETE | `/:id` | Delete a gym challenge | Yes |
| GET | `/:joinId/join` | Join a gym challenge using a join ID | Yes |
| GET | `/:challengeId/members` | Get all members of a specific gym challenge | No |
| POST | `/:challengeId/members` | Add a member to a gym challenge | Yes |
| POST | `/:challengeId/logs` | Add an exercise log to a gym challenge | Yes |
| GET | `/:challengeId/logs` | Get logs for a challenge, grouped by user | Yes |
| GET | `/:challengeId/ranking` | Get the ranking for a gym challenge | Yes |

---

## **Health Check**

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| GET | `/health` | Check if the API is running | No |

---

## **404 Not Found**

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| ANY | `*` | Catch-all for undefined routes |

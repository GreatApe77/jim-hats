# Jim Hats Spring Boot API Endpoints & Checklist

This document tracks the implementation status of the REST API endpoints for the `jim-hats-web-api` Spring Boot application.

**Legend:**
- ✅ **Implemented**: Endpoint exists in the Java Controller.
- 🚧 **Proposed**: Endpoint is required by the entity model or frontend features but is not yet implemented.

---

## 1. Authentication
**Base Path:** `/auth`
**Controller:** `AuthenticationController`

| Status | Method | Endpoint | Description |
| :---: | :--- | :--- | :--- |
| ✅ | `POST` | `/auth/register` | Register a new user with `username`, `email`, `password`, `firstName`, `lastName`. |
| ✅ | `POST` | `/auth/login` | Authenticate a user and return a JWT token. |
| 🚧 | `POST` | `/auth/refresh` | **(Optional)** Refresh an expired JWT token. |

---

## 2. Exercise Check-ins (Logs)
**Base Path:** `/check-ins`
**Controller:** `ExerciseCheckInController` (New)

*Rationale: Check-ins are a top-level resource because they can exist independently or be linked to multiple challenges simultaneously via the `ExerciseCheckInToChallengeAssignment` entity.*

| Status | Method | Endpoint | Description |
| :---: | :--- | :--- | :--- |
| 🚧 | `POST` | `/check-ins` | Create a new check-in. Body includes optional `gymChallengeIds: [Long]` to link to challenges. |
| 🚧 | `GET` | `/check-ins/{id}` | Get details of a specific check-in. |
| 🚧 | `PATCH` | `/check-ins/{id}` | Update a check-in (e.g., fix typo in description). |
| 🚧 | `DELETE` | `/check-ins/{id}` | Delete a check-in (cascades to remove assignments). |

---

## 3. Gym Challenges
**Base Path:** `/gym-challenges`
**Controller:** `GymChallengeController`

| Status | Method | Endpoint | Description |
| :---: | :--- | :--- | :--- |
| ✅ | `POST` | `/gym-challenges` | Create a new gym challenge. |
| 🚧 | `GET` | `/gym-challenges` | List all active gym challenges (with optional pagination/search). |
| 🚧 | `GET` | `/gym-challenges/{id}` | Get details of a specific challenge by ID. |
| 🚧 | `PUT` | `/gym-challenges/{id}` | Update a challenge's details (restricted to the creator). |
| 🚧 | `DELETE` | `/gym-challenges/{id}` | Delete a challenge (restricted to the creator). |
| 🚧 | `POST` | `/gym-challenges/{id}/join` | Join a specific challenge (Add current user to members). |
| 🚧 | `POST` | `/gym-challenges/{id}/leave` | Leave a specific challenge. |
| 🚧 | `GET` | `/gym-challenges/{id}/members` | List all users participating in a challenge. |
| 🚧 | `GET` | `/gym-challenges/{id}/check-ins` | Get the feed of check-ins specific to this challenge (Read-Only). |
| 🚧 | `GET` | `/gym-challenges/{id}/ranking` | Get the leaderboard/ranking for the challenge based on check-ins. |

---

## 4. Users
**Base Path:** `/users`
**Controller:** `UserController`

| Status | Method | Endpoint | Description |
| :---: | :--- | :--- | :--- |
| ✅ | `GET` | `/users/{userId}` | Get public profile details of a specific user by ID. |
| 🚧 | `GET` | `/users/me` | Get the currently authenticated user's profile information. |
| 🚧 | `PATCH` | `/users/me` | Update the current user's profile (e.g., profile picture, names). |
| 🚧 | `DELETE` | `/users/me` | Delete the current user's account. |
| 🚧 | `GET` | `/users/me/check-ins` | Get the authenticated user's personal history of check-ins. |

---

## 5. System & Utilities
**Base Path:** `/`
**Controller:** `HealthController`

| Status | Method | Endpoint | Description |
| :---: | :--- | :--- | :--- |
| ✅ | `GET` | `/health` | Returns "API is healthy" to verify system status. |
| 🚧 | `POST` | `/uploads` | Upload generic files/images (if not handled directly in entity creation). |

---

## Implementation Task List

### Authentication
- [x] Register User
- [x] Login User
- [ ] Refresh Token

### Exercise Check-ins (Core Feature)
- [ ] **Create Check-in** (Handle file upload + linking to Challenge IDs)
- [ ] Get Check-in Details
- [ ] Update Check-in
- [ ] Delete Check-in

### Gym Challenges
- [x] Create Challenge
- [ ] List Challenges (Feed/Search)
- [ ] Get Challenge Details
- [ ] Update Challenge
- [ ] Delete Challenge
- [ ] Join/Leave Logic
- [ ] **Challenge Feed** (Get logs filtered by Challenge ID)
- [ ] **Ranking Algorithm** (Calculate scores based on logs)

### Users
- [x] Get User by ID
- [ ] Get Me (Authenticated Profile)
- [ ] Update Me
- [ ] Delete Me
- [ ] User's Check-in History
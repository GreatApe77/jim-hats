import { SaveUserParams } from "../../src/users/repository/interfaces/IUserRepository";

export const mockUsers: SaveUserParams[] = [
  {
    username: "john_doe",
    email: "john@example.com",
    password: "securepassword1",
    profilePicture: "john_profile.jpg",
  },
  {
    username: "jane_smith",
    email: "jane@example.com",
    password: "securepassword2",
    profilePicture: "jane_profile.jpg",
  },
  {
    username: "bob_jones",
    email: "bob@example.com",
    password: "securepassword3",
    profilePicture: null,
  },
];

import { describe } from "node:test";
import { beforeAll, beforeEach, expect, it, vi } from "vitest";
import {
  IUserRepository,
  SaveUserParams,
} from "../src/users/repository/interfaces/IUserRepository";
import { UserRepository } from "../src/users/repository/implementations/UserRepository";
import prisma from "../src/db/__mocks__/prisma";
import { IUser } from "../src/users/IUser";
vi.mock("../src/db/prisma");

describe("UserRepository tests", () => {
  const mockedUser: IUser = {
    createdAt: new Date(),
    email: "test@test.com",
    id: 1,
    password: "abc123",
    profilePicture: "https://pic.com",
    updatedAt: new Date(),
    username: "usernametest",
  };

  let usersRepo: IUserRepository;
  beforeEach(() => {
    usersRepo = new UserRepository();
  });

  it("Should create a user", async () => {});
  it("should find by email", async () => {});
  it("Should not find by email (does not exist)", async () => {});
  it("Should find by id", async () => {});
  it("Should not find by id (does not exist)", async () => {});
  it("Should find by username", async () => {});
  it("Should not find by username (does not exist)", async () => {});
  it("Should find all users", async () => {});
  it("Should update a user", async () => {});
  it("Should delete a user", async () => {});
});

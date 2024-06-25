import { describe } from "node:test";
import { beforeAll, beforeEach, expect, it, vi } from "vitest";
import {
  IUserRepository,
  SaveUserParams,
} from "../../src/domain/users/repository/interfaces/IUserRepository";
import { UserRepository } from "../../src/domain/users/repository/implementations/UserRepository";
import prisma from "../../src/db/__mocks__/prisma";
import { IUser } from "../../src/domain/users/IUser";
vi.mock("../../src/db/prisma");

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
  beforeAll(async () => {
    await prisma.user.createMany({
      data: [mockedUser],
    });
  });

  let usersRepo: IUserRepository;
  beforeEach(() => {
    usersRepo = new UserRepository();
  });

  it("Should create a user", async () => {
    const newUser: SaveUserParams = {
      email: "test@test.com",
      username: "usernametest",
      password: "abc123",
      profilePicture: "https://pic.com",
    };
    const now = new Date();
    prisma.user.create.mockResolvedValue({
      ...newUser,
      id: 1,
      createdAt: now,
      updatedAt: now,
    });
    expect(await usersRepo.save(newUser)).to.not.throw;
  });
  it("should find by email", async () => {
    const user: IUser = { ...mockedUser };
    prisma.user.findUnique.mockResolvedValue(user);
    const foundUser = await usersRepo.findByEmail("test@test.com");
    expect(foundUser).toStrictEqual(user);
  });
  it("Should not find by email (does not exist)", async () => {
    prisma.user.findUnique.mockResolvedValue(null);
    const foundUser = await usersRepo.findByEmail("mateus@test.com");
    expect(foundUser).toBeNull();
  });
  it("Should find by id", async () => {
    const user: IUser = { ...mockedUser };
    prisma.user.findUnique.mockResolvedValue(user);
    const foundUser = await usersRepo.findById(1);
    expect(foundUser).toStrictEqual(user);
  });
  it("Should not find by id (does not exist)", async () => {
    prisma.user.findUnique.mockResolvedValue(null);
    const foundUser = await usersRepo.findById(2);
    expect(foundUser).toBeNull();
  });
  it("Should find by username", async () => {
    const user: IUser = { ...mockedUser };
    prisma.user.findUnique.mockResolvedValue(user);
    const foundUser = await usersRepo.findByUsername("usernametest");
    expect(foundUser).toStrictEqual(user);
  });
  it("Should not find by username (does not exist)", async () => {
    prisma.user.findUnique.mockResolvedValue(null);
    const foundUser = await usersRepo.findByUsername("mateus");
    expect(foundUser).toBeNull();
  });
  it("Should find all users", async () => {
    prisma.user.findMany.mockResolvedValue([mockedUser]);

    const users = await usersRepo.findAll({});
    expect(users).toStrictEqual([mockedUser]);
  });
  it("Should update a user", async () => {
    const updatedUser: IUser = { ...mockedUser, username: "newusername" };
    prisma.user.update.mockResolvedValue(updatedUser);
    expect(await usersRepo.update(1, {
      username: "newusername",
      email: "test@test.com",
      password: "abc123",
      profilePicture: "https://pic.com",
    })).to.not.throw;
    expect(prisma.user.update).toHaveBeenCalledWith({
      where: { id: 1 },
      data: {
        updatedAt: expect.any(Date),
        username: "newusername",
        email: "test@test.com",
        password: "abc123",
        profilePicture: "https://pic.com",
      },
    });
  });
  it("Should delete a user", async () => {
    expect(await usersRepo.delete(1)).to.not.throw;
    expect(prisma.user.delete).toHaveBeenCalledWith({
      where: { id: 1 },
    });
  });
});

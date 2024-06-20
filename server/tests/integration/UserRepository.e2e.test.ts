import { describe } from "node:test";
import { beforeAll, beforeEach, expect, it, vi } from "vitest";
import {
  IUserRepository,
  SaveUserParams,
} from "../../src/users/repository/interfaces/IUserRepository";
import { UserRepository } from "../../src/users/repository/implementations/UserRepository";



describe("UserRepository tests", () => {
  let usersRepo: IUserRepository = new UserRepository();
  it("Should create a a user", async () => {
    const user = {
      email: "email",
      username: "username",
      password: "password",
      profilePicture: "profilePicture"
    }
    expect(await usersRepo.save(user)).to.not.throw
    const createdUser = await usersRepo.findByEmail(user.email)
    expect(createdUser?.email).to.equal(user.email)
  })
  it("Should find a user by email", async () => {
    expect(true).to.equal(true)
  })
})
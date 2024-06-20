import { describe } from "node:test";
import { beforeAll, beforeEach, expect, it, vi } from "vitest";
import {
  IUserRepository,
  SaveUserParams,
} from "../../src/users/repository/interfaces/IUserRepository";
import { UserRepository } from "../../src/users/repository/implementations/UserRepository";



describe("UserRepository tests", () => {

  it("Should create a bruh", async () => {
    expect(true).toBe(true)
  })
})
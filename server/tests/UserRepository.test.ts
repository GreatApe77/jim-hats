import { describe } from "node:test";
import { beforeEach, expect, it, vi } from "vitest";
import { IUserRepository, SaveUserParams } from "../src/users/repository/interfaces/IUserRepository";
import {UserRepository} from "../src/users/repository/implementations/UserRepository"
import prisma from "../src/db/__mocks__/prisma"
vi.mock("../src/db/prisma");

describe("UserRepository tests", () => {
    let usersRepo:IUserRepository
    beforeEach(()=>{
        usersRepo = new UserRepository()
    })
    
    it("Should create a user",async  () => {
    const newUser: SaveUserParams = {
        
        email:"test@test.com",
        username:"usernametest",
        password:"abc123",
        profilePicture:"https://pic.com",

    }
    const now = new Date()
    prisma.user.create.mockResolvedValue({...newUser,id:1,createdAt:now,updatedAt:now})
     expect(await usersRepo.save(newUser)).to.not.throw
  });
});

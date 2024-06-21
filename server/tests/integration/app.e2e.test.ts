import { describe, expect, it } from "vitest";
import request from "supertest";
import { app } from "../../src/app";
import { setupUsers } from "./setup";
import { SaveUserParams } from "../../src/users/repository/interfaces/IUserRepository";

const mockValidUser:SaveUserParams = {
    username:"GreatApe77",
    email:"great@gmail.com",
    password:"password123",
    profilePicture:"https://domain.com/pic.png"
}
describe("app e2e tests", () => {
  describe("auth", () => {

    setupUsers()


    it("( POST /register ) Should register a user",async()=>{
        const response = await request(app).post("/register").send(mockValidUser)
        expect(response.status).to.be.eq(201)
    });
  });
});

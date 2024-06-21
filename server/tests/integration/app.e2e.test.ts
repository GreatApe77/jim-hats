import { describe, expect, it } from "vitest";
import request from "supertest";
import { app } from "../../src/app";
import { setupUsers } from "./setup";
import { SaveUserParams } from "../../src/users/repository/interfaces/IUserRepository";
import { MESSAGES } from "../../src/constants/MESSAGES";
import { LoginUserDTO } from "../../src/auth/dto/LoginUserDTO";

const mockValidUser: SaveUserParams = {
  username: "GreatApe77",
  email: "great@gmail.com",
  password: "password123",
  profilePicture: "https://domain.com/pic.png",
};
describe("app e2e tests", () => {
  describe("auth", () => {
    const registerRoute = "/register";
    const loginRoute = "/login"
    setupUsers();

    it("( POST /register ) Should register a user", async () => {
      const response = await request(app)
        .post(registerRoute)
        .send(mockValidUser);
      expect(response.status).to.be.eq(201);
      expect(response.body.message).toBe(MESSAGES.REGISTERED_USER);
    });
    it("( POST /register ) Should NOT register a user ( username not unique )", async () => {
      await request(app).post(registerRoute).send(mockValidUser);
      const response = await request(app)
        .post(registerRoute)
        .send(mockValidUser);
      expect(response.status !== 201).to.be.true;
      expect(response.body.message!==MESSAGES.REGISTERED_USER).to.be.true
    });

    it("( POST /login ) Should login",async ()=>{
        await request(app).post(registerRoute).send(mockValidUser);
        const loginUser:LoginUserDTO = {
            password:mockValidUser.password,
            username:mockValidUser.username
        }                                                                                                    
        const response = await request(app).post(loginRoute).send(
            loginUser
        )
        expect(response.status).to.be.eq(200)
        expect(response.body.message).to.be.eq(MESSAGES.LOGIN_USER_SUCCESS)
        expect(response.body.token).toBeDefined

    })

    it("( POST /login ) Should NOT login ( wrong password )",async ()=>{
        await request(app).post(registerRoute).send(mockValidUser);
        const loginUser:LoginUserDTO = {
            password:"wrongPassword",
            username:mockValidUser.username
        }                                                                                                    
        const response = await request(app).post(loginRoute).send(
            loginUser
        )
        expect(response.status!==200).to.be.true
        expect(response.body.message!==MESSAGES.LOGIN_USER_SUCCESS).to.be.true
        expect(response.body.token).toBeUndefined
    })

  });
});

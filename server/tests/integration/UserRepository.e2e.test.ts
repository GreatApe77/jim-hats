import { describe } from "node:test";
import { expect, it } from "vitest";
import {
  IUserRepository,
  SaveUserParams,
} from "../../src/domain/users/repository/interfaces/IUserRepository";
import { UserRepository } from "../../src/domain/users/repository/implementations/UserRepository";
import { setupUsers } from "./setup";

const sampleUserToSave: SaveUserParams = {
  email: "email",
  username: "username",
  password: "password",
  profilePicture: "profilePicture",
};
describe("UserRepository tests", () => {
  const usersRepo: IUserRepository = new UserRepository();

  setupUsers();

  it("Should create a a user", async () => {
    expect(await usersRepo.save(sampleUserToSave)).to.not.throw;
  });
  it("Should not create a user with the same email", async () => {
    await usersRepo.save(sampleUserToSave);
    expect(() => usersRepo.save(sampleUserToSave)).toThrow;
  });
  it("Should not create a user with the same username", async () => {
    await usersRepo.save(sampleUserToSave);
    expect(() => usersRepo.save({ ...sampleUserToSave, email: "email2" }))
      .toThrow;
  });
  it("Should find a user by username", async () => {
    await usersRepo.save(sampleUserToSave);
    const user = await usersRepo.findByUsername(sampleUserToSave.username);
    expect(user).to.not.be.undefined;
    expect(user?.email).to.equal(sampleUserToSave.email);
    expect(user?.username).to.equal(sampleUserToSave.username);
  });
  it("Should update a user", async () => {
    await usersRepo.save(sampleUserToSave);
    const user = await usersRepo.findByUsername(sampleUserToSave.username);
    await usersRepo.update(user!.id, {
      email: "newEmail",
      username: "newUsername",
      password: "newPassword",
      profilePicture: "newProfilePicture",
    });
    const updatedUser = await usersRepo.findByUsername("newUsername");
    expect(updatedUser).to.not.be.undefined;
    expect(updatedUser?.username).to.equal("newUsername");
  });
  it("Should update a user only username", async () => {
    await usersRepo.save(sampleUserToSave);
    const user = await usersRepo.findByUsername(sampleUserToSave.username);
    await usersRepo.update(user!.id, {
      username: "newUsername",
    });
    const updatedUser = await usersRepo.findByUsername("newUsername");
    expect(updatedUser).to.not.be.undefined;
    expect(updatedUser?.username).to.equal("newUsername");
    expect(updatedUser?.email).to.equal(sampleUserToSave.email);
  });
  it("Should delete a user", async () => {
    await usersRepo.save(sampleUserToSave);
    const user = await usersRepo.findByUsername(sampleUserToSave.username);
    await usersRepo.delete(user!.id);
    const deleted = await usersRepo.findByUsername(sampleUserToSave.username);
    expect(deleted).to.be.null;
  });
  it("Should find a user by email", async () => {
    await usersRepo.save(sampleUserToSave);
    const user = await usersRepo.findByEmail(sampleUserToSave.email);
    expect(user).to.not.be.undefined;
    expect(user?.email).to.equal(sampleUserToSave.email);
    expect(user?.username).to.equal(sampleUserToSave.username);
  });
  it("Should list all users (Date)", async () => {
    await usersRepo.save(sampleUserToSave);
    const users = await usersRepo.findAll(new Date());
    expect(users.length).to.equal(4);
  });
  it("Should list all users (offset and limit)", async () => {
    await usersRepo.save(sampleUserToSave);
    const users = await usersRepo.findAll({ offset: 1, limit: 1 });
    expect(users.length).to.equal(1);
  });
});

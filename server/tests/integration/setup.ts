import { beforeEach } from "vitest";
import prisma from "../../src/db/prisma";
import { mockUsers } from "../constants/mockUsers";

export function setupUsers() {
  beforeEach(async () => {
    await prisma.user.deleteMany();
    await prisma.user.createMany({
      data: mockUsers,
    });
  });
}

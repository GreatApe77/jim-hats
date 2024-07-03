import { PrismaClientKnownRequestError } from "@prisma/client/runtime/library";
import { environment } from "../../../../config/environment";
import {
  IUserRepository,
  SaveUserParams,
} from "../../../users/repository/interfaces/IUserRepository";
import { DecodedPayload, IAuthService } from "../interfaces/IAuthService";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { HttpError } from "../../../../errors/HttpError";
import { MESSAGES } from "../../../../constants/MESSAGES";
export class AuthService implements IAuthService {
  userRepository: IUserRepository;

  constructor(userRepository: IUserRepository) {
    this.userRepository = userRepository;
  }

  async register(user: SaveUserParams): Promise<void> {
    const hashedPassword = await bcrypt.hash(user.password, 10);
    user.password = hashedPassword;
    try {
      await this.userRepository.save(user);
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === "P2002") {
          throw new HttpError(400, MESSAGES.USER_ALREADY_EXISTS);
        }
      }
      throw error;
    }
  }
  async login(username: string, password: string): Promise<string> {
    const user = await this.userRepository.findByUsername(username);
    if (!user) {
      throw new HttpError(404, MESSAGES.USER_NOT_FOUND);
    }
    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) {
      throw new HttpError(401, MESSAGES.WRONG_PASSWORD);
    }
    const token = jwt.sign(
      {
        id: user.id,
        username: user.username,
      },
      environment.JWT_SECRET,
      {
        expiresIn: "30d",
      },
    );
    return token;
  }
  async verifyToken(token: string): Promise<DecodedPayload> {
    try {
      const decodedPayload = jwt.verify(token, environment.JWT_SECRET);
      return decodedPayload as DecodedPayload;
    } catch (error) {
      throw new HttpError(401, MESSAGES.INVALID_JWT_TOKEN);
    }
  }
}

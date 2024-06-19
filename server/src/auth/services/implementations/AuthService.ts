import { IUserRepository, SaveUserParams } from "../../../users/repository/interfaces/IUserRepository";
import { IAuthService } from "../interfaces/IAuthService";
import bcrypt from "bcrypt"
import jwt from "jsonwebtoken"
export class AuthService implements IAuthService {
    userRepository: IUserRepository;

    constructor(userRepository: IUserRepository) {
        this.userRepository = userRepository;
    }

    async register(user: SaveUserParams): Promise<void> {
        const hashedPassword = await bcrypt.hash(user.password, 10)
        user.password = hashedPassword
        await this.userRepository.save(user)
    }
    async login(username: string, password: string): Promise<string> {
        const user = await this.userRepository.findByUsername(username)
        if (!user) {
            throw new Error("User not found")
        }
        const passwordMatch = await bcrypt.compare(password, user.password)
        if (!passwordMatch) {
            throw new Error("Invalid password")
        }
        const token = jwt.s
    }
    async verifyToken(token: string): Promise<boolean> {

    }

}
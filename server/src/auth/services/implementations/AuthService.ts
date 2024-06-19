import { environment } from "../../../config/environment";
import { IUserRepository, SaveUserParams } from "../../../users/repository/interfaces/IUserRepository";
import { DecodedPayload, IAuthService } from "../interfaces/IAuthService";
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
        const token = jwt.sign({
            id:user.id
        },environment.JWT_SECRET,{
            expiresIn:"30d"
        })
        return token
    }
    async verifyToken(token: string): Promise<DecodedPayload> {
        try {
            const decodedPayload = jwt.verify(token,environment.JWT_SECRET)
            return decodedPayload as DecodedPayload
        } catch (error) {
            throw new Error("Invalid token")
        }
    }

}
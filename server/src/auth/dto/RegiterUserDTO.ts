import { IUser } from "../../users/IUser";
export type RegisterUserDTO = Pick<IUser,"email"|"username"|"profilePicture"|"password">
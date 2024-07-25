export type ServiceResponse<T> = {
  status: number;
  success: boolean;
  response: ApiResponse<T>;
};
export type ApiResponse<T> = {
  message: string;
  data?: T;
};
export type RegisterDto = {
  username: string;
  email: string;
  password: string;
  profilePicture: string | null;
};
export type CreateAccountFormData = {
  username: string;
  email: string;
  password: string;
  confirmPassword: string;
  profilePicture: string | null;
};

export type LoginFormData = {
  username: string;
  password: string;
};

export type GymChallenge = {
  id: number;
  name: string;
  description: string;
  image: string | null;
  createdAt: string;
  startAt: string;
  endAt: string;
  creatorId: number;
};
export type LoggedUser = {
  id: number;
  username: string;
  email: string;
  profilePicture: string | null;
};
export type ChallengeMember = Omit<LoggedUser, "email"> 

export type CreateChallengeFormData = {
  name: string;
  description: string | null;
  startAt: string;
  endAt: string;
  image: string | null;
};

export type ExerciseLog = {
  id: number;
  title: string;
  description: string | null;
  image: string;
  date: string;
  userId: number;
  gymChallengeId: number;
};
export type ExerciseLogWithUser = ExerciseLog & {
  user:{
    username: string;
    profilePicture: string | null;

  }
}

export type Ranking ={
  id: number;
  username: string;
  profilePicture: string | null;
  logCount: number;
};

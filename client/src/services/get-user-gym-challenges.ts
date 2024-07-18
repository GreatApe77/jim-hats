import { GymChallenge, ServiceResponse } from "@/types";

export async function getUserGymChallenges(token: string) {
  const response = await fetch(
    `${process.env.NEXT_PUBLIC_API_ENDPOINT}/users/me/gym-challenges`,
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    },
  );
  const jsonData = await response.json();
  return {
    status: response.status,
    success: response.ok,
    response: {
      data: jsonData.data,
      message: jsonData.message,
    },
  } as ServiceResponse<GymChallenge[]>;
}

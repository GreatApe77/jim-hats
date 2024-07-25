import { ChallengeMember, ServiceResponse } from "@/types";

export async function getUsersOfChallenge(challengeId: string, token: string) {
  const response = await fetch(`${process.env.NEXT_PUBLIC_API_ENDPOINT}/gym-challenges/${challengeId}/members`, {
    method: "GET",
    headers: {
      Authorization: `Bearer ${token}`,
    },
  });
  const jsonData = await response.json();
  return {
    status: response.status,
    success: response.ok,
    response: {
      message: jsonData.message,
      data: jsonData.data as ChallengeMember[],
    },
  } as ServiceResponse<ChallengeMember[]>;
  
}
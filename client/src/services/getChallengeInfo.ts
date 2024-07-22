import { GymChallenge, ServiceResponse } from "@/types";

export async function getChallengeInfo(token: string, id: string) {
  const response = await fetch(
    `${process.env.NEXT_PUBLIC_API_ENDPOINT}/gym-challenges/${id}`,
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
    response:{
        data:jsonData.data,
        message:jsonData.message
    }
  } as ServiceResponse<GymChallenge>;
}

import { Ranking, ServiceResponse } from "@/types";

export async function getRanking(challengeId: string,token:string) {
  const response = await fetch(
    `${process.env.NEXT_PUBLIC_API_ENDPOINT}/gym-challenges/${challengeId}/ranking`,
    {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${token}`,
        },
    },
  );
  const jsonData = await response.json();
  return {
    response:{
        message: jsonData.message,
        data: jsonData.data,
    },
    status: response.status,
    success: response.ok,
  } as ServiceResponse<Ranking[]>
}

import { API_URL } from "@/constants";
import { ServiceResponse } from "@/types";

export async function joinChallenge(joinId: string, token: string) {
  const response = await fetch(`${API_URL}/gym-challenges/${joinId}/join`, {
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
      data: jsonData.data,
    },
  } as ServiceResponse<undefined>;
}

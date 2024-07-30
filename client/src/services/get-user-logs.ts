import { API_URL } from "@/constants";
import { ServiceResponse, ExerciseLog } from "@/types";

export async function getUserLogs(token: string) {
  const response = await fetch(
    `${API_URL}/users/me/logs`,
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
  } as ServiceResponse<ExerciseLog[]>;
}
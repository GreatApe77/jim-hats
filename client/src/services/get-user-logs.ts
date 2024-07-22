import { ServiceResponse, ExerciseLog } from "@/types";

export async function getUserLogs(token: string) {
  const response = await fetch(
    `${process.env.NEXT_PUBLIC_API_ENDPOINT}/users/me/logs`,
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
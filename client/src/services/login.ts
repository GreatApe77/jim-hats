import { API_URL } from "@/constants";
import { ServiceResponse } from "@/types";

export async function login(username: string, password: string) {
  const response = await fetch(
    `${API_URL}/login`,
    {
      method: "POST",
      body: JSON.stringify({ username, password }),
      headers: {
        "Content-Type": "application/json",
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
  } as ServiceResponse<{ token: string }>;
}

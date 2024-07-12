import { ApiResponse, ServiceResponse } from "@/types";

export async function login(username: string, password: string) {
  const response = await fetch(
    `${process.env.NEXT_PUBLIC_API_ENDPOINT}/login`,
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

import { API_URL } from "@/constants";
import { LoggedUser, ServiceResponse } from "@/types";

export async function getMe(token: string) {
  const response = await fetch(
    `${API_URL}/users/me`,
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
    response: {
      message: jsonData.message,
      data: jsonData.data,
    },
    status: response.status,
    success: response.ok,
  } as ServiceResponse<LoggedUser>;
}

import { API_URL } from "@/constants";
import { RegisterDto, ServiceResponse } from "@/types";

export async function register(userData: RegisterDto) {
  const response = await fetch(
    API_URL + "/register",
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(userData),
    },
  );
  const data = await response.json();
  return {
    status: response.status,
    success: response.ok,
    response: {
      message: data.message,
    },
  } as ServiceResponse<undefined>;
}

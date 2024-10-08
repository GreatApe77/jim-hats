import { API_URL } from "@/constants";
import { CreateExerciseLogFormData, ServiceResponse } from "@/types";

export async function logExercise(
  challengeId: string,
  token: string,
  exerciseFormData: CreateExerciseLogFormData,
) {
  const response = await fetch(
    `${API_URL}/gym-challenges/${challengeId}/logs`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify(exerciseFormData),
    },
  );
  const jsonDate = await response.json();
  return {
    status: response.status,
    success: response.ok,
    response: {
      data: undefined,
      message: jsonDate.message,
    },
  } as ServiceResponse<undefined>;
}

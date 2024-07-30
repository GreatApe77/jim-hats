import { API_URL } from "@/constants";
import { ExerciseLog, ExerciseLogWithUser, ServiceResponse } from "@/types";

export async function getLogsOfChallenge(challengeId: string, token: string) {
    const response = await fetch(`${API_URL}/gym-challenges/${challengeId}/logs`, {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${token}`
        }
    });
    const jsonData = await response.json();
    return {
        status: response.status,
        success: response.ok,
        response:{
            message: jsonData.message,
            data: jsonData.data as ExerciseLogWithUser[]
        }
    } as ServiceResponse<ExerciseLogWithUser[]>

}
import { API_URL } from "@/constants";
import { CreateChallengeFormData, ServiceResponse } from "@/types";
export async function createChallenge(
  challengeData: CreateChallengeFormData,
  token: string
) {
  const response = await fetch(`${API_URL}/gym-challenges`,
    {
        method:"POST",
        headers:{
            "Content-Type":"application/json",
            Authorization:`Bearer ${token}`
        },
        body:JSON.stringify(challengeData)
    }
  )
    const data = await response.json()
    return {
        status:response.status,
        success:response.ok,
        response:{
            message:data.message
        },
        
    } as ServiceResponse<undefined>
}
import { ApiResponse } from "@/types/ApiResponse"
import { ServiceResponse } from "@/types/ServiceReponse";

export type RegisterData = {
  username: string;
  email: string;
  password: string;
};

export async function register(userData: RegisterData):Promise<ServiceResponse<undefined>>{
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_ENDPOINT}/auth/register`,{
        method:"POST",
        body:JSON.stringify(userData),
        headers:{
            "Content-Type":"application/json"
        }
    })
    const data = await response.json()
    return data as ServiceResponse<undefined>
}

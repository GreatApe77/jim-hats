import { RegisterDto, ServiceResponse } from "@/types";

export async function register(userData:RegisterDto){
    const response = await fetch(process.env.NEXT_PUBLIC_API_URL + "/auth/register",{
        method:"POST",
        headers:{
            "Content-Type":"application/json"
        },
        body:JSON.stringify(userData)
    })
    const data = await response.json()
    return {
        status:response.status,
        success:response.ok,
        response:{
            message:data.message,
            
        },
    
    } as ServiceResponse<undefined>
}
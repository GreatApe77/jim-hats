import { ServiceResponse } from "@/types/ServiceReponse"

export async function login(username:string,password:string){
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_ENDPOINT}/auth/login`,{
        method:"POST",
        body:JSON.stringify({username,password}),
        headers:{
            "Content-Type":"application/json"
        }
    })
    const data = await response.json()
    return data as ServiceResponse<{token:string} | undefined>
}
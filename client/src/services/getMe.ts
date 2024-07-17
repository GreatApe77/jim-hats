import { LoggedUser, ServiceResponse } from "@/types";

export async function getMe(token:string){
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_ENDPOINT}/users/me`, {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
        },
    });
    const jsonData = await response.json();
    return {
        response:{
            message: jsonData.message,
            data: jsonData.data,
        },
        status: response.status,
        success: response.ok,
    } as ServiceResponse<LoggedUser>;
    
}
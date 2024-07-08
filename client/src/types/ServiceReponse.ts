import { ApiResponse } from "./ApiResponse";

export type ServiceResponse<T> ={
    status:number;
    response:ApiResponse<T>
}
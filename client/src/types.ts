export type ServiceResponse<T> = {
    status: number,
    success: boolean,
    response:ApiResponse<T>

}
export type ApiResponse<T> = {
    message: string,
    data: T
}
export type CreateAccountFormData = {
    username:string,
    email:string,
    password:string,
    confirmPassword:string
    profilePicture:string|null
}
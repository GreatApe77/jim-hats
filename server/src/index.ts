import { app } from "./app";
import { environment } from "./config/environment";



async function main(){

    app.listen(environment.PORT,()=>{
        console.log(`Server is running on ${environment.PORT}`)
    })
}

main()
.catch((error)=>{
    console.error(error)
    process.exit(1)
})
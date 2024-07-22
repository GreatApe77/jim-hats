"use client"
import { useParams } from "next/navigation"

export default function ChallengePage(){
    const params = useParams()
    console.log(params.id)
    return (
        <>
        <div>
            <h1>Challenge</h1>
            <p>Welcome to the challenge page {params.id}</p>
        </div>
        </>
    )
}
"use client";
import { getChallengeInfo } from "@/services/getChallengeInfo";
import { getLocalStorageToken } from "@/utils/getLocalStorageToken";
import { useQuery } from "@tanstack/react-query";

export function useChallenge(challengeId: string) {
    return useQuery({
        queryKey: ["getChallengeInfo"],
        queryFn: () => getChallengeInfo(getLocalStorageToken() as string ,challengeId),
        //enabled: !!getLocalStorageToken(),
    })
}
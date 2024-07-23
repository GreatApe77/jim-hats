"use client";
import { getRanking } from "@/services/get-ranking";
import { getLocalStorageToken } from "@/utils/getLocalStorageToken";
import { useQuery } from "@tanstack/react-query";

export function useRanking(challengeId: string) {
    return useQuery({
        queryKey: ["getRanking"],
        queryFn: () => getRanking(challengeId,getLocalStorageToken() as string),
       //enabled: !!getLocalStorageToken(),
    })
}
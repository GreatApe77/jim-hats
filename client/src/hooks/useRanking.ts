
import { getRanking } from "@/services/get-ranking";
import { useQuery } from "@tanstack/react-query";

export function useRanking(challengeId: string) {
    return useQuery({
        queryKey: ["getRanking"],
        queryFn: () => getRanking(challengeId,localStorage.getItem("token")!),
        enabled: !!localStorage.getItem("token"),
    })
}
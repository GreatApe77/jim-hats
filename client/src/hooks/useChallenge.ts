import { getChallengeInfo } from "@/services/getChallengeInfo";
import { useQuery } from "@tanstack/react-query";

export function useChallenge(challengeId: string) {
    return useQuery({
        queryKey: ["getChallengeInfo"],
        queryFn: () => getChallengeInfo(localStorage.getItem("token")! ,challengeId),
        enabled: !!localStorage.getItem("token"),
    })
}
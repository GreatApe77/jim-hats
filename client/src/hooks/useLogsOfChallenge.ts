"use client";
import { getLogsOfChallenge } from "@/services/get-logs-of-challenge";
import { getUserGymChallenges } from "@/services/get-user-gym-challenges";
import { getLocalStorageToken } from "@/utils/getLocalStorageToken";
import { useQuery } from "@tanstack/react-query";

export function useLogsOfChallenge(challengeId: string) {
  return useQuery({
    queryKey: ["getLogsOfChallenge"],
    queryFn: () =>
      getLogsOfChallenge(challengeId,getLocalStorageToken() as string),
  });
}

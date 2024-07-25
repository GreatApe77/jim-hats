"use client";
import { getUsersOfChallenge } from "@/services/get-users-of-challenge";
import { getLocalStorageToken } from "@/utils/getLocalStorageToken";
import { useQuery } from "@tanstack/react-query";

export function useMembersOfChallenge(challengeId: string) {
  return useQuery({
    queryKey: ["getUsersOfChallenge"],
    queryFn: () =>
      getUsersOfChallenge(challengeId, getLocalStorageToken() as string),
    //enabled: !!getLocalStorageToken(),
  });
}

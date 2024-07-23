"use client";
import { getUserGymChallenges } from "@/services/get-user-gym-challenges";
import { getLocalStorageToken } from "@/utils/getLocalStorageToken";
import { useQuery } from "@tanstack/react-query";

export function useChallengesOfUser() {
  return useQuery({
    queryKey: ["getUserGymChallenges"],
    queryFn: () =>
      getUserGymChallenges(getLocalStorageToken() as string),
  });
}

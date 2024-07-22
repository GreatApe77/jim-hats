import { getUserGymChallenges } from "@/services/get-user-gym-challenges";
import { useQuery } from "@tanstack/react-query";

export function useChallengesOfUser() {
  return useQuery({
    queryKey: ["getUserGymChallenges"],
    queryFn: () =>
      getUserGymChallenges(localStorage.getItem("token") as string),
  });
}

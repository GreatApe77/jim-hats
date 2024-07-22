import { getMe } from "@/services/getMe";
import { useQuery } from "@tanstack/react-query";

export function useLoggedUser() {
  return useQuery({
    queryKey: ["getMe"],
    queryFn: () => getMe(localStorage.getItem("token") as string),
    enabled: !!localStorage.getItem("token"),
  });
}

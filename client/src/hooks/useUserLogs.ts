import { getUserLogs } from "@/services/get-user-logs";
import { useQuery } from "@tanstack/react-query";

export function useUserLogs() {
  return useQuery({
    queryKey: ["getUserLogs"],
    queryFn: () => getUserLogs(localStorage.getItem("token") as string),
    enabled: !!localStorage.getItem("token"),
  });
}

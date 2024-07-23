"use client";
import { getUserLogs } from "@/services/get-user-logs";
import { getLocalStorageToken } from "@/utils/getLocalStorageToken";
import { useQuery } from "@tanstack/react-query";

export function useUserLogs() {
  return useQuery({
    queryKey: ["getUserLogs"],
    queryFn: () => getUserLogs(getLocalStorageToken() as string),
    //enabled: !!localStorage.getItem("token"),
  });
}

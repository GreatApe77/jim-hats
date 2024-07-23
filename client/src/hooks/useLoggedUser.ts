"use client";
import { getMe } from "@/services/getMe";
import { getLocalStorageToken } from "@/utils/getLocalStorageToken";
import { useQuery } from "@tanstack/react-query";

export function useLoggedUser() {
  return useQuery({
    queryKey: ["getMe"],
    queryFn: () => getMe(getLocalStorageToken() as string),
   // enabled: !!localStorage.getItem("token"),
  });
}

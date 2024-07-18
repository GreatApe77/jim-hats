"use client";
import { getMe } from "@/services/getMe";
import { LoggedUser } from "@/types";
import { useQuery } from "@tanstack/react-query";
import { createContext, useContext } from "react";

type LoggedUserProviderProps = {
  children: React.ReactNode;
};
export const LoggedUserContext = createContext<LoggedUser | null>(null);
export function LoggedUserProvider({ children }: LoggedUserProviderProps) {
  const token = localStorage.getItem("token");

  const { data: response } = useQuery({
    queryKey: ["getMe"],
    queryFn: () => getMe(token!),
    enabled: !!token,
  });
  return (
    <LoggedUserContext.Provider
      value={response?.response.data ? response?.response.data : null}
    >
      {children}
    </LoggedUserContext.Provider>
  );
}
export function useLoggedUser() {
  const context = useContext(LoggedUserContext);

  return context;
}

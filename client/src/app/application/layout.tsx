"use client";
import { CreateChallengeModalProvider } from "@/contexts/CreateChallengeModalContext";
import { JoinChallengeModalProvider } from "@/contexts/JoinChallengeModalContext";
import { getLocalStorageToken } from "@/utils/getLocalStorageToken";
import { LocalizationProvider } from "@mui/x-date-pickers";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { getMe } from "@/services/getMe";
const client = new QueryClient();
export default function ApplicationLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const router = useRouter();
  useEffect(() => {
    const token = getLocalStorageToken();
    if(!token){
      router.push("/")
    }else{
      getMe(token).then((serviceResponse) => {
        if(serviceResponse.status!==200){
          localStorage.removeItem("token")
          router.push("/")
        }
      })
    }
  }, []);
  return (
    <>
      <QueryClientProvider client={client}>
        <CreateChallengeModalProvider>
          <JoinChallengeModalProvider>
            <LocalizationProvider dateAdapter={AdapterDayjs}>
              {children}
            </LocalizationProvider>
          </JoinChallengeModalProvider>
        </CreateChallengeModalProvider>
      </QueryClientProvider>
    </>
  );
}

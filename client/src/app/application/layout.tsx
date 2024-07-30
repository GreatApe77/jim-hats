"use client";
import { CreateChallengeModalProvider } from "@/contexts/CreateChallengeModalContext";
import { JoinChallengeModalProvider } from "@/contexts/JoinChallengeModalContext";
import { LocalizationProvider } from "@mui/x-date-pickers";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

const client = new QueryClient();
export default function ApplicationLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
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

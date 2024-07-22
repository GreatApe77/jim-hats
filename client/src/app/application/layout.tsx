"use client";
import { CreateChallengeModalProvider } from "@/contexts/CreateChallengeModalContext";
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
          <LocalizationProvider dateAdapter={AdapterDayjs}>
            {children}
          </LocalizationProvider>
        </CreateChallengeModalProvider>
      </QueryClientProvider>
    </>
  );
}

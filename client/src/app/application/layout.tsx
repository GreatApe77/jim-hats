"use client";
import { CreateChallengeModalProvider } from "@/contexts/CreateChallengeModalContext";
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
        <CreateChallengeModalProvider>{children}</CreateChallengeModalProvider>
      </QueryClientProvider>
    </>
  );
}

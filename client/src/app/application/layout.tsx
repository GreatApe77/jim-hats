"use client"
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

const client = new QueryClient()
export default function ApplicationLayout({
    children
}: Readonly<{
    children: React.ReactNode;
}>) {
    return <>
        <QueryClientProvider client={client}>

            {children}
        </QueryClientProvider>

    </>;
}
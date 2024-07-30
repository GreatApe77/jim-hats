import { createContext, useState } from "react";

interface JoinChallengeModalContextType {
  open: boolean;
  setOpen: (open: boolean) => void;
}

export const JoinChallengeModalContext = createContext<
JoinChallengeModalContextType | undefined
>(undefined);

export function JoinChallengeModalProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [open, setOpen] = useState(false);

  return (
    <JoinChallengeModalContext.Provider value={{ open, setOpen }}>
      {children}
    </JoinChallengeModalContext.Provider>
  );
}

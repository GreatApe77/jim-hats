import { createContext, useState } from "react";

interface CreateChallengeModalContextType {
  open: boolean;
  setOpen: (open: boolean) => void;
}

export const CreateChallengeModalContext = createContext<
  CreateChallengeModalContextType | undefined
>(undefined);

export function CreateChallengeModalProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [open, setOpen] = useState(false);

  return (
    <CreateChallengeModalContext.Provider value={{ open, setOpen }}>
      {children}
    </CreateChallengeModalContext.Provider>
  );
}

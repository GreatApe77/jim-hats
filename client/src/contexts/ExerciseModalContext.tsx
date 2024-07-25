import { createContext, useState } from "react";

interface ExerciseModalContextType {
  open: boolean;
  setOpen: (open: boolean) => void;
}

export const ExerciseModalContext = createContext<
ExerciseModalContextType | undefined
>(undefined);

export function ExerciseModalProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [open, setOpen] = useState(false);

  return (
    <ExerciseModalContext.Provider value={{ open, setOpen }}>
      {children}
    </ExerciseModalContext.Provider>
  );
}

import { useState } from "react";
import { createContext } from "react";

interface ExercisePictureContextType {
  exercisePictureFile: File | null;
  setExercisePictureFile: (file: File) => void;
}

export const ExercisePictureContext = createContext<
    ExercisePictureContextType | undefined
>(undefined);

export function ExercisePictureProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [exercisePictureFile, setExercisePictureFile] = useState<File | null>(
    null,
  );

  return (
    <ExercisePictureContext.Provider
      value={{ exercisePictureFile, setExercisePictureFile }}
    >
      {children}
    </ExercisePictureContext.Provider>
  );
}

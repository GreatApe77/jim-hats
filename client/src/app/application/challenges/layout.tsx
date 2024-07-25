"use client";
import MainDrawer from "@/components/MainDrawer";
import { ExerciseModalProvider } from "@/contexts/ExerciseModalContext";
import { ExercisePictureProvider } from "@/contexts/ExercisePictureContext";
import { useChallengesOfUser } from "@/hooks/useChallengesOfUser";
import { useLoggedUser } from "@/hooks/useLoggedUser";

export default function ChallengesLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const { data: gymChallengesResponse } = useChallengesOfUser();
  const { data: loggedUserResponse } = useLoggedUser();
  const user = loggedUserResponse?.response.data;
  const challenges = gymChallengesResponse?.response.data?.map((challenge) => {
    return {
      ...challenge,
      id: challenge.id.toString(),
    };
  });
  return (
    <>
      <ExercisePictureProvider>
        <ExerciseModalProvider>
          <MainDrawer user={user} challenges={challenges} />
          {children}
        </ExerciseModalProvider>
      </ExercisePictureProvider>
    </>
  );
}

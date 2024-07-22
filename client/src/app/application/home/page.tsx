"use client";
import MainDrawer from "@/components/MainDrawer";
import { useChallengesOfUser } from "@/hooks/useChallengesOfUser";
import { useLoggedUser } from "@/hooks/useLoggedUser";

export default function MainAppPage() {
  const { data: gymChallengesResponse } = useChallengesOfUser();
  //const user = useLoggedUser()
  const { data: response } = useLoggedUser();
  const user = response?.response.data;
  const challenges = gymChallengesResponse?.response.data;

  return (
    <>
      <MainDrawer
        user={user}
        challenges={challenges?.map((challenge) => {
          return {
            ...challenge,
            id: challenge.id.toString(),
          };
        })}
      />
      <div>
        <h1>Home</h1>
        <p>Welcome to the home page</p>
      </div>
    </>
  );
}

"use client";
import MainDrawer from "@/components/MainDrawer";
import { useChallengesOfUser } from "@/hooks/useChallengesOfUser";
import { useLoggedUser } from "@/hooks/useLoggedUser";

export default function UserCheckinsPage() {
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
      <MainDrawer user={user} challenges={challenges} />
    </>
  );
}

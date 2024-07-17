"use client";
import MainDrawer from "@/components/MainDrawer";
import { useLoggedUser } from "@/contexts/LoggedUserContext";
import { getUserGymChallenges } from "@/services/get-user-gym-challenges";
import { getMe } from "@/services/getMe";
import { useQuery } from "@tanstack/react-query";

export default function MainAppPage() {

  const { data: gymChallengesResponse } = useQuery({

    queryKey: ["getUserGymChallenges"],
    queryFn: () => getUserGymChallenges(localStorage.getItem("token") as string),

  })
  //const user = useLoggedUser()
  const {data:response} = useQuery({
    queryKey:["getMe"],
    queryFn:()=>getMe(localStorage.getItem("token") as string),
    enabled: !!localStorage.getItem("token"),
  })
  const user = response?.response.data
  const challenges = gymChallengesResponse?.response.data

  return (
    <>
    <MainDrawer user={user} challenges={challenges} />
      <div>
        <h1>Home</h1>
        <p>Welcome to the home page</p>

      </div>
    </>
  );
}

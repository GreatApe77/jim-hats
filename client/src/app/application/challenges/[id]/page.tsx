"use client";
import ChallengeBanner from "@/components/ChallengeBanner";
import { useChallenge } from "@/hooks/useChallenge";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { Container, Typography } from "@mui/material";
import { useParams } from "next/navigation";

export default function ChallengePage() {
  const params = useParams();
  const challengeId = params.id as string;
  const {data:loggedUserResponse} = useLoggedUser();
  
  const { data: challengeResponse } = useChallenge(challengeId);
  const challenge = challengeResponse?.response.data;
  const user = loggedUserResponse?.response.data;
  return (
    <>
    <Container maxWidth="sm">

      <Typography variant="h6">{challenge?.name}</Typography>
      <ChallengeBanner 
        challengeImage="https://images.pexels.com/photos/3077882/pexels-photo-3077882.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        endDate={challenge?.endAt!}
        you={{
          count: 5,
          profilePicture: user?.profilePicture || "",
        }}
        leader={{
          count: 20,
          profilePicture: "https://images.pexels.com/photos/3077882/pexels-photo-3077882.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        }}

      />
    </Container>
    </>
  );
}

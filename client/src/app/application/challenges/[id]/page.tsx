"use client";
import ChallengeBanner from "@/components/ChallengeBanner";
import { useChallenge } from "@/hooks/useChallenge";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { useRanking } from "@/hooks/useRanking";
import { Container, Typography } from "@mui/material";
import { useParams } from "next/navigation";

export default function ChallengePage() {
  const params = useParams();
  const challengeId = params.id as string;
  const {data:loggedUserResponse} = useLoggedUser();
  const {data:rankingResponse} = useRanking(challengeId);
  
  const { data: challengeResponse } = useChallenge(challengeId);
  const challenge = challengeResponse?.response.data;
  const user = loggedUserResponse?.response.data;
  const ranking = rankingResponse?.response.data;
  return (
    <>
    <Container maxWidth="sm">

      <Typography variant="h6">{challenge?.name}</Typography>
      <ChallengeBanner 
        challengeImage={challenge?.image}
        endDate={challenge?.endAt!}
        you={{
          count: ranking?.find((r) => r.id === user?.id)?.logCount || 0,
          profilePicture: user?.profilePicture || "",
        }}
        leader={{
          count: ranking?.[0]?.logCount || 0,
          profilePicture: ranking?.[0]?.profilePicture || "",
        }}

      />
    </Container>
    </>
  );
}

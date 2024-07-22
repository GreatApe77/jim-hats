"use client";
import { useChallenge } from "@/hooks/useChallenge";
import { Container, Typography } from "@mui/material";
import { useParams } from "next/navigation";

export default function ChallengePage() {
  const params = useParams();
  const challengeId = params.id as string;
  const { data: challengeResponse } = useChallenge(challengeId);
  const challenge = challengeResponse?.response.data;
  return (
    <>
    <Container maxWidth="sm">

      <Typography variant="h6">{challenge?.name}</Typography>
    </Container>
    </>
  );
}

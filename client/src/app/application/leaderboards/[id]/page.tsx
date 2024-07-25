"use client";
import BackButton from "@/components/BackButton";
import { useChallenge } from "@/hooks/useChallenge";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { useMembersOfChallenge } from "@/hooks/useMembersOfChallenge";
import { useRanking } from "@/hooks/useRanking";
import { Avatar, Box, Container, Stack, Typography } from "@mui/material";
import LinearProgress from "@mui/material/LinearProgress";
import dayjs from "dayjs";
import { useParams } from "next/navigation";

export default function LeaderboardsOfChallengePage() {
  const params = useParams();
  const challengeId = params.id as string;

  const { data: loggedUserResponse } = useLoggedUser();
  const { data: rankingResponse } = useRanking(challengeId);
  const { data: challengeResponse } = useChallenge(challengeId);
  const { data: membersOfChallengeResponse } =
    useMembersOfChallenge(challengeId);
  const challenge = challengeResponse?.response.data;
  const user = loggedUserResponse?.response.data;
  const ranking = rankingResponse?.response.data;
  const members = membersOfChallengeResponse?.response.data;
  const daysPassed = dayjs().diff(dayjs(challenge?.startAt), "day");
  const total =
    challenge?.startAt && challenge?.endAt
      ? dayjs(challenge?.endAt).diff(challenge?.startAt, "day")
      : 0;
  const progress = (daysPassed / total) * 100;
  const challengeIsOver = dayjs().isAfter(dayjs(challenge?.endAt));
  return (
    <>
      <BackButton to={`/application/challenges/${challengeId}`} />
      <Container maxWidth="sm">
        <Typography variant="h6" gutterBottom>
          {challenge?.name}
        </Typography>
        <Typography  gutterBottom>
            {challenge?.description}
        </Typography>
        <LinearProgress
          variant="determinate"
          value={challengeIsOver ? 100 : progress}
        />
        <Stack direction="row" justifyContent="space-between">
          <Typography variant="caption">
            Starts: {dayjs(challenge?.startAt).format("DD/MM/YYYY")}
          </Typography>
          <Typography variant="caption">
            End: {dayjs(challenge?.endAt).format("DD/MM/YYYY")}
          </Typography>
        </Stack>
        <br />
        <Typography  gutterBottom>
            {members?.length} members
        </Typography>
        <Stack spacing={1} direction={"row"} sx={{
            overflowX: "auto",
        }}>
            {members?.map((member)=>{
                return <>
                <Avatar src={member.profilePicture || ""} alt={member.username} />
                </>
            })}
            
        </Stack>
        <br />
        <Typography  gutterBottom>
            Rankings
        </Typography>
        <Stack spacing={1} >
            {ranking?.map((rank)=>{
                return <>
                    <Stack direction={"row"} justifyContent={"space-between"}>
                        <Stack direction={"row"} spacing={2}>
                            <Avatar src={rank.profilePicture || ""} alt={rank.username} />
                            <Box>
                                <Typography >
                                    {rank.username}
                                </Typography>
                                <Typography variant="body2">
                                    {rank.logCount} check-ins
                                </Typography>
                            </Box>
                        </Stack>
                        <Typography variant="body2">
                            
                        </Typography>
                    </Stack>
                </>
            })}
        </Stack>
      </Container>
    </>
  );
}

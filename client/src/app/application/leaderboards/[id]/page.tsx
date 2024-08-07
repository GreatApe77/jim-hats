"use client";
import BackButton from "@/components/BackButton";
import { useChallenge } from "@/hooks/useChallenge";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { useMembersOfChallenge } from "@/hooks/useMembersOfChallenge";
import { useRanking } from "@/hooks/useRanking";
import CalendarMonthSharpIcon from "@mui/icons-material/CalendarMonthSharp";
import MonitorHeartSharpIcon from "@mui/icons-material/MonitorHeartSharp";
import { Avatar, Box, Container, IconButton, Stack, Typography } from "@mui/material";
import LinearProgress from "@mui/material/LinearProgress";
import dayjs from "dayjs";
import { useParams } from "next/navigation";
import ContentCopyIcon from '@mui/icons-material/ContentCopy';
import { useState } from "react";
export default function LeaderboardsOfChallengePage() {
  const params = useParams();
  const challengeId = params.id as string;
  const [copied, setCopied] = useState(false);
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
  const totalCheckIns = ranking?.reduce((accumulator, current) => {
    return accumulator + current.logCount;
  }, 0);
  const averagePerDay = totalCheckIns ? totalCheckIns / daysPassed : 0;
  return (
    <>
      <BackButton to={`/application/challenges/${challengeId}`} />
      <Container maxWidth="sm">
        <Typography variant="h6" gutterBottom>
          {challenge?.name}
        </Typography>
        <Typography gutterBottom>{challenge?.description}</Typography>
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
        <Typography gutterBottom>{members?.length} members</Typography>
        <Stack
          spacing={1}
          direction={"row"}
          sx={{
            overflowX: "auto",
          }}
        >
          {members?.map((member) => {
            return (
              <>
                <Avatar
                  src={member.profilePicture || ""}
                  alt={member.username}
                />
              </>
            );
          })}
        </Stack>
        <br />
        <Typography gutterBottom>Rankings</Typography>
        <Stack spacing={1}>
          {ranking?.map((rank) => {
            return (
              <>
                <Stack direction={"row"} justifyContent={"space-between"}>
                  <Stack direction={"row"} spacing={2}>
                    <Avatar
                      src={rank.profilePicture || ""}
                      alt={rank.username}
                    />
                    <Box>
                      <Typography>{rank.username}</Typography>
                      <Typography variant="body2">
                        {rank.logCount} check-ins
                      </Typography>
                    </Box>
                  </Stack>
                  <Typography variant="h6">Xst</Typography>
                </Stack>
              </>
            );
          })}
        </Stack>
        <br />
        <Typography gutterBottom>Group stats</Typography>
        <Stack spacing={1}>
          <Stack direction={"row"} spacing={2}>
            <Avatar alt={"rank"}>
              <MonitorHeartSharpIcon />
            </Avatar>
            <Box>
              <Typography>{totalCheckIns}</Typography>
              <Typography variant="body2">Total check-ins</Typography>
            </Box>
          </Stack>

          <Stack direction={"row"} spacing={2}>
            <Avatar alt={"calendar"}>
              <CalendarMonthSharpIcon />
            </Avatar>
            <Box>
              <Typography>{daysPassed ===0?totalCheckIns:averagePerDay.toFixed(2)}</Typography>
              <Typography variant="body2">Average workouts per day</Typography>
            </Box>
          </Stack>
        </Stack>
        {challenge?.joinId && (
          <>
            <Typography gutterBottom variant="h6" mt={2}>
              Join code :
            </Typography>
            <Typography gutterBottom>
              Share this code with your friends to join the challenge
            </Typography>
            <Typography variant="caption">{challenge?.joinId}

              <IconButton size="small"
              onClick={
                () => {
                  navigator.clipboard.writeText(challenge?.joinId!);
                  setCopied(true);
                  setTimeout(() => {
                    setCopied(false);
                  }, 2000);
                }
              }>
                <ContentCopyIcon color={copied?"info":"inherit"} />
              </IconButton>
              {
                copied && <Typography variant="caption" component={"span"} color="info">Copied to clipboard!</Typography>
              }
            </Typography>
          </>
        )}
      </Container>
    </>
  );
}

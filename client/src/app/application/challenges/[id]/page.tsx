"use client";
import ChallengeBanner from "@/components/ChallengeBanner";
import LogCard from "@/components/LogCard";
import { useChallenge } from "@/hooks/useChallenge";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { useLogsOfChallenge } from "@/hooks/useLogsOfChallenge";
import { useRanking } from "@/hooks/useRanking";
import { ExerciseLogWithUser } from "@/types";
import { Container, Fab, Skeleton, Stack, Typography } from "@mui/material";
import dayjs from "dayjs";
import AddIcon from "@mui/icons-material/Add";
import { useParams, useRouter } from "next/navigation";
import { VisuallyHiddenInput } from "@/components/VisuallyHiddenInput";
import LogExerciseModal from "@/components/LogExerciseModal";
import { useContext, useEffect } from "react";
import { ExercisePictureContext } from "@/contexts/ExercisePictureContext";
import { ExerciseModalContext } from "@/contexts/ExerciseModalContext";

function groupLogsByDate(logs: ExerciseLogWithUser[]) {
  return logs.reduce((groups, log) => {
    const date = log.date.split("T")[0];
    //@ts-ignore
    if (!groups[date]) {
      //@ts-ignore
      groups[date] = [];
    }
    //@ts-ignore
    groups[date].push(log);
    return groups;
  }, {});
}
export default function ChallengePage() {
  useEffect(()=>{
    
    localStorage.setItem("lastVisitedChallengeId", challengeId)
  },[])
  const params = useParams();
  const router = useRouter();
  const exercisePicContext = useContext(ExercisePictureContext)
  const exerciseModalContext = useContext(ExerciseModalContext)
  const challengeId = params.id as string;
  const { data: loggedUserResponse } = useLoggedUser();
  const { data: rankingResponse } = useRanking(challengeId);
  const { data: challengeResponse } = useChallenge(challengeId);
  const {
    data: logsResult,
    isError,
    isLoading,
  } = useLogsOfChallenge(challengeId);

  if (!isLoading && logsResult?.status !== 200) {
    return router.push("/");
  }
  const logsOfChallenge = logsResult?.response.data;
  const challenge = challengeResponse?.response.data;
  const user = loggedUserResponse?.response.data;
  const ranking = rankingResponse?.response.data;
  //if(!user || !challenge || !ranking || !logsOfChallenge) {
  //  router.push("/");
  //  return null;
  //}
  const groupedLogs = groupLogsByDate(logsOfChallenge || []);
  const today = dayjs().format("YYYY-MM-DD");
  const yesterday = dayjs().subtract(1, "day").format("YYYY-MM-DD");
  return (
    <>
      <Container maxWidth="sm">
        {
          challenge?.name?
          
          <Typography variant="h6">{challenge?.name}</Typography>
          : <Skeleton variant="text" />
        }
        {!isLoading && !isError && challenge && ranking && user ? (
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
            onClick={
              () => router.push(`/application/leaderboards/${challengeId}`)
            }
          />
        ) : (
          <Skeleton variant="rectangular" height={200} />
        )}

        <br />

        {Object.keys(groupedLogs).map((date) => (
          <>
            <Typography
              variant="h6"
              color={"GrayText"}
              marginTop={1}
              textAlign={"center"}
              gutterBottom
            >
              {dayjs(date).isSame(today)
                ? "Today"
                : dayjs(date).isSame(yesterday)
                  ? "Yesterday"
                  : dayjs(date).format("DD/MM/YYYY")}
            </Typography>
            <Stack spacing={2}>
              {/*@ts-ignore*/}
              {groupedLogs[date].map((log) => (
                <LogCard
                  key={log.id}
                  logDate={log.date}
                  logImage={log.image}
                  logTitle={log.title}
                  username={log.user.username}
                  usernameProfilePic={log.user.profilePicture}
                />
              ))}
            </Stack>
          </>
        ))}
      </Container>
      <Fab 
      sx={
        {
          margin: 0,
          top: 'auto',
          right: 20,
          bottom: 40,
          left: 'auto',
          position: 'fixed',
      }
      }
        component="label"
      color="primary">
        <VisuallyHiddenInput type="file" 
          accept="image/*"
          onChange={(event) => {
            const file = event.target.files?.[0];
            if (file) {
              exercisePicContext?.setExercisePictureFile(file)
              exerciseModalContext?.setOpen(true)
            }
          }}
        />
        <AddIcon />
      </Fab>
      <LogExerciseModal/>
    </>
  );
}

"use client";
import ChallengeBanner from "@/components/ChallengeBanner";
import LogCard from "@/components/LogCard";
import { useChallenge } from "@/hooks/useChallenge";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { useLogsOfChallenge } from "@/hooks/useLogsOfChallenge";
import { useRanking } from "@/hooks/useRanking";
import { Container, Typography } from "@mui/material";
import { useParams, /*useRouter */} from "next/navigation";

export default function ChallengePage() {
  const params = useParams();
  //const router = useRouter();
  const challengeId = params.id as string;
  const { data: loggedUserResponse } = useLoggedUser();
  const { data: rankingResponse } = useRanking(challengeId);
  const { data: challengeResponse } = useChallenge(challengeId);
  const { data: logs } = useLogsOfChallenge(challengeId);
  const logsOfChallenge = logs?.response.data;
  const challenge = challengeResponse?.response.data;
  const user = loggedUserResponse?.response.data;
  const ranking = rankingResponse?.response.data;
  //if(!user || !challenge || !ranking || !logsOfChallenge) {
  //  router.push("/");
  //  return null;
  //}
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
        <br />
        
        <LogCard
          logDate={new Date().toISOString()}
          logImage="https://www.google.com"
          logTitle="My log"
          username="Jim"
          usernameProfilePic={user?.profilePicture}
        />
        <h1>
          logs
        </h1>
        {
          logsOfChallenge?.map((log) => {
            return (
              <LogCard
                key={log.id}
                logDate={log.date}
                logImage={log.image}
                logTitle={log.title}
                username={log.user.username}
                usernameProfilePic={log.user.profilePicture}
              />
            );
          })
        }
      </Container>
    </>
  );
}

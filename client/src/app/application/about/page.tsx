"use client"
import MainDrawer from "@/components/MainDrawer";
import { GITHUB_REPO_URL } from "@/constants";
import { useChallengesOfUser } from "@/hooks/useChallengesOfUser";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { Container, Link, Typography } from "@mui/material";

export default function AboutPage() {
  const { data: response } = useLoggedUser();
  const {data:gymChallengesResponse} = useChallengesOfUser();
  const user = response?.response.data;
  const challenges = gymChallengesResponse?.response.data?.map((challenge) => {
      return {
        ...challenge,
        id: challenge.id.toString(),
      };
    });
  return (
    <>
      <MainDrawer
      challenges={challenges}
      user={user}
      />
      <Container maxWidth="md">
        <Typography variant="h5" gutterBottom>
          About
        </Typography>
        <Typography variant="body1" mb={2}>
          What's up Rats!
        </Typography>
        <Typography variant="body1" mb={2}>
          This project is a simplified clone of the GymRats App that can be
          found{" "}
          <Link href="https://www.gymrats.app/" target="_blank">
            HERE
          </Link>
          .
        </Typography>
        <Typography variant="body1" mb={2}>
          The source code of this project can be found on my
            <Link href={GITHUB_REPO_URL} target="_blank">
                {" "}
                GitHub
            </Link>.
        </Typography>
        <Typography variant="body1" mb={2}>
          Happy ratting,
        </Typography>
        <Typography variant="body1" >
          Mateus Navarro
        </Typography>
        <Typography variant="caption" mb={2}>
          Developer
        </Typography>


        

      </Container>
    </>
  );
}

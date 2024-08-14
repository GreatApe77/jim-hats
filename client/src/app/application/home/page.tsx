"use client";
import MainDrawer from "@/components/MainDrawer";
import { CreateChallengeModalContext } from "@/contexts/CreateChallengeModalContext";
import { JoinChallengeModalContext } from "@/contexts/JoinChallengeModalContext";
import { useChallengesOfUser } from "@/hooks/useChallengesOfUser";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { Box, Button, Container, Stack, Typography } from "@mui/material";
import Image from "next/image";
import { useContext } from "react";

export default function MainAppPage() {
  const { data: gymChallengesResponse } = useChallengesOfUser();
  const createChallengeContext = useContext(CreateChallengeModalContext)
  const joinChallengeContext = useContext(JoinChallengeModalContext)
  //const user = useLoggedUser()
  const { data: response } = useLoggedUser();
  const user = response?.response.data;
  const challenges = gymChallengesResponse?.response.data;

  return (
    <>
      <MainDrawer
        user={user}
        challenges={challenges?.map((challenge) => {
          return {
            ...challenge,
            id: challenge.id.toString(),
          };
        })}
      />
      <>
        <Container
        sx={{
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "center",
          height: "100vh",
        }}
        >
          <Box>
            <Image
              style={{
                width: "100%",
                maxWidth: "200px",
                borderRadius: "50%",
              }}
              src={"/rat.jpg"}
              alt="rat"
              width={"200"}
              height={"200"}
            />
          </Box>
          <Typography variant="h5" mt={1} gutterBottom textAlign={"center"}>
            Welcome, {user?.username} !
          </Typography>
          <Typography variant="body1" gutterBottom textAlign={"center"}>
            You are not currently participating in any challenges.
          </Typography>
          
          <Stack direction={"row"} spacing={1}>
            <Button  variant="contained"
            onClick={()=>joinChallengeContext?.setOpen(true)}>
            
              Join 
            </Button>
            <Button
              
              
              onClick={()=>createChallengeContext?.setOpen(true)}
            >
              Create
            </Button>
          </Stack>
        </Container>
      </>
    </>
  );
}

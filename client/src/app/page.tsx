import { Box, Button, Container, Grid, Link, Stack, Typography } from "@mui/material";
import Image from "next/image";
export default function Home() {
  return (
    <main >
      <Container maxWidth="md" sx={{
        minHeight: "100vh",
        display: "flex",
        flexDirection: "column",
        justifyContent: "center"

      }}
      >



        <Stack direction={"column"} spacing={2} flexGrow={1} alignSelf={"center"} textAlign={"center"} >
          <Box display={"flex"} flexDirection={"column"} height={"100%"} margin={"auto"}>

            <Box textAlign={"center"} >
              <Image style={{
                width: "100%",
                maxWidth: "200px",
              }} src={"/rat.jpg"} alt="rat" width={"200"} height={"200"} />

            </Box>

            <Typography variant="h5">Welcome to
              <Box fontWeight={"bold"} display={"inline"}>
                {" "}Jim Hats

              </Box>
            </Typography>
          </Box>
        </Stack>
        <Box  >
          <Stack direction={"column"} spacing={1} >
            <Button variant="contained" color="primary" size="large" fullWidth>Create Account</Button>
            <Typography gutterBottom variant="body1">Already have an account? <Link underline="hover" color="primary">Login</Link></Typography>

          </Stack>
        </Box>




      </Container>
    </main >
  );
}

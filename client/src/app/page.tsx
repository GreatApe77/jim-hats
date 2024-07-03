import { Box, Button, Container, Link, Stack, Typography } from "@mui/material";
import Image from "next/image";
export default function Home() {
  return (
    <main >
      <Container maxWidth="md" sx={{
        minHeight: "100vh",
        display: "flex",
        flexDirection: "column",
        justifyContent: "center",

      }}
      >


        <Stack direction={"column"} spacing={2} mt={24} textAlign={"center"} flexGrow={1}>

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
        </Stack>
        <Box display={"flex"} flexDirection={"column"}  justifyContent={"end"}>
          <Stack direction={"column"} spacing={1} >
            <Button variant="contained" color="primary" fullWidth>Create Account</Button>
            <Typography gutterBottom variant="body1">Already have an account? <Link underline="hover" color="primary">Login</Link></Typography>

          </Stack>
        </Box>



      </Container>
    </main >
  );
}

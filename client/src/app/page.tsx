import { Box, Button, Container, Link as MUILink, Stack, Typography } from "@mui/material";
import Image from "next/image";
import Link  from "next/link";

export default function Home() {
  
  return (
    <main>
      <Container maxWidth="md" sx={{
        minHeight: "100vh",
        display: "flex",
        flexDirection: "column",
        justifyContent: "space-between",
        alignItems: "center",
      }}>
        <Box sx={{ flexGrow: 1, display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', textAlign: 'center' }}>
          <Box>
            <Image style={{
              width: "100%",
              maxWidth: "200px",
            }} src={"/rat.jpg"} alt="rat" width={"200"} height={"200"} />
          </Box>
          <Typography variant="h5">
            Welcome to
            <Box fontWeight={"bold"} display={"inline"}>{" "}Jim Hats</Box>
          </Typography>
        </Box>

        <Box sx={{ width: '100%', mt: 'auto' }}>
          <Stack direction={"column"} spacing={1}>
            <Button LinkComponent={Link} href="/create-account"  variant="contained" color="primary" size="large" fullWidth>Create Account</Button>
            <Typography gutterBottom variant="body1">Already have an account? <MUILink component={Link} href={"/login"}  underline="hover" color="primary">Login</MUILink></Typography>
          </Stack>
        </Box>
      </Container>
    </main>
  );
}

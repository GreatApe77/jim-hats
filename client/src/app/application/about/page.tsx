import MainDrawer from "@/components/MainDrawer";
import { Container, Link, Typography } from "@mui/material";

export default function AboutPage() {
  return (
    <>
      <MainDrawer />
      <Container>
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
            <Link href="https://github.com/GreatApe77/jim-hats" target="_blank">
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

import { Container, Stack, Typography } from "@mui/material";
import Link from "next/link";
import { Link as MUILink } from "@mui/material";
export default function NotFound() {
  return (
    <>
      <Container
        maxWidth="md"
        sx={{
          minHeight: "100vh",
          display: "flex",
          flexDirection: "column",
          justifyContent: "center",
          alignItems: "center",
        }}
      >
        <Stack direction={"column"} spacing={1}>
          <Typography variant="h6">Page not found!</Typography>
          <Typography variant="body1">
            Sorry, we could not find the page you were looking for.
          </Typography>

          <MUILink
            component={Link}
            href={"/"}
            underline="hover"
            color="primary"
          >
            Go back to the home page
          </MUILink>
        </Stack>
      </Container>
    </>
  );
}

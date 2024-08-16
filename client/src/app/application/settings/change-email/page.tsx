"use client";
import BackButton from "@/components/BackButton";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { Button, Container, Stack, TextField, Typography } from "@mui/material";

export default function ChangeEmailPage() {
  const { data: loggedUserResponse } = useLoggedUser();
  const loggedUser = loggedUserResponse?.response.data;

  return (
    <>
      <BackButton to="/application/settings" />
      <Container maxWidth="md">
        <Typography variant="h5" gutterBottom>
          Email
        </Typography>
        <Typography variant="body1" gutterBottom>
          Your email is your identifier to sign in to Jim Hats. if you forget your password, you can reset it using your email.
        </Typography>
        <Stack spacing={2}>
          <TextField
            defaultValue={loggedUser?.email}
            label={"Email"}
            name="email"
            fullWidth
            autoFocus
            
          />
          <Button variant="contained" color="primary" fullWidth>
            Save
          </Button>
        </Stack>
      </Container>
    </>
  );
}

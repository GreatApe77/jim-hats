"use client";
import BackButton from "@/components/BackButton";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { Button, Container, Stack, TextField, Typography } from "@mui/material";

export default function ChangeNamePage() {
  const { data: loggedUserResponse } = useLoggedUser();
  const loggedUser = loggedUserResponse?.response.data;

  return (
    <>
      <BackButton to="/application/settings" />
      <Container maxWidth="md">
        <Typography variant="h5" gutterBottom>
          Name
        </Typography>
        <Typography variant="body1" gutterBottom>
          Set your username
        </Typography>
        <Stack spacing={2}>
          <TextField
            defaultValue={loggedUser?.username}
            label={"Username"}
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

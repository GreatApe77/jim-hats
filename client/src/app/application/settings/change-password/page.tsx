"use client";
import BackButton from "@/components/BackButton";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { Button, Container, Stack, TextField, Typography } from "@mui/material";

export default function ChangePasswordPage() {
  const { data: loggedUserResponse } = useLoggedUser();
  const loggedUser = loggedUserResponse?.response.data;

  return (
    <>
      <BackButton to="/application/settings" />
      <Container maxWidth="md">
        <Typography variant="h5" gutterBottom>
          Password
        </Typography>
        <Typography variant="body1" gutterBottom>
          Password must be between 8 and 20 characters long.
        </Typography>
        <Stack spacing={2}>
            <TextField
                label={"Current password"}
                type="password"
                fullWidth
                autoFocus
            />
            <TextField
                label={"New password"}
                type="password"
                fullWidth
            />
            <TextField
                label={"Confirm new password"}
                type="password"
                fullWidth
            />
            <Button variant="contained" color="primary" fullWidth>
                Save
            
            </Button>
        </Stack>
      </Container>
    </>
  );
}

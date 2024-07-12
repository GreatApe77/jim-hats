import BackButton from "@/components/BackButton";
import {
  Box,
  Button,
  Container,
  Stack,
  TextField,
  Typography,
} from "@mui/material";

export default function LoginPage() {
  return (
    <>
      <BackButton to="/" />
      <Container maxWidth="md">
        <Box>
          <Typography variant="h6" gutterBottom>
            Login
          </Typography>
          <Typography variant="body1" gutterBottom>
            Welcome back.
          </Typography>
        </Box>
        <Stack spacing={2}>
          <TextField variant="outlined" label="Username" />
          <TextField variant="outlined" label="Password" type="password" />
        </Stack>
        <Stack spacing={2} sx={{ marginTop: "1rem" }}>
          <Button variant="contained" size="large" fullWidth>
            Login
          </Button>
          <Button variant="outlined" color="inherit" fullWidth>
            Forgot Password
          </Button>
        </Stack>
      </Container>
    </>
  );
}

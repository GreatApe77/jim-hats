"use client";
import BackButton from "@/components/BackButton";
import { login } from "@/services/login";
import { LoginFormData } from "@/types";
import {
  Box,
  Button,
  Container,
  Stack,
  TextField,
  Typography,
} from "@mui/material";
import { useRouter } from "next/navigation";
import { useState } from "react";

export default function LoginPage() {
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [loginData, setLoginData] = useState<LoginFormData>({
    username: "",
    password: "",
  });

  function handleFormChange(e: React.ChangeEvent<HTMLInputElement>) {
    setLoginData({
      ...loginData,
      [e.target.name]: e.target.value,
    });
  }
  function handleLoginSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    //console.log(loginData);
    setLoading(true);
    login(loginData.username, loginData.password)
      .then((serviceResponse) => {
        if (serviceResponse.status === 200) {
          const token = serviceResponse.response.data?.token as string;
          localStorage.setItem("token", token);

          router.push("/application/home");
        } else {
          alert(serviceResponse.response.message);
        }
      })
      .catch((error) => {
        alert("An error occurred while logging in");
      })
      .finally(() => {
        setLoading(false);
      });
  }
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
        <form onSubmit={handleLoginSubmit}>
          <Stack spacing={2}>
            <TextField
              variant="outlined"
              label="Username"
              name="username"
              onChange={handleFormChange}
              required
            />
            <TextField
              variant="outlined"
              label="Password"
              type="password"
              name="password"
              onChange={handleFormChange}
              required
            />
          </Stack>
          <Stack spacing={2} sx={{ marginTop: "1rem" }}>
            <Button type="submit" variant="contained" size="large" fullWidth disabled={loading}>
              
              {loading ? "Logging in..." : "Login"}
            </Button>
            <Button variant="outlined" color="inherit" fullWidth>
              Forgot Password
            </Button>
          </Stack>
        </form>
      </Container>
    </>
  );
}

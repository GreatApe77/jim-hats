"use client";
import {
  Avatar,
  Box,
  Button,
  CircularProgress,
  Container,
  IconButton,
  Stack,
  TextField,
  Typography,
  styled,
} from "@mui/material";
import KeyboardArrowLeftIcon from "@mui/icons-material/KeyboardArrowLeft";
import Badge from "@mui/material/Badge";
import CreateIcon from "@mui/icons-material/Create";
import { useRef, useState } from "react";
import Link from "next/link";
import BackButton from "@/components/BackButton";
import { CreateAccountFormData } from "@/types";
import { QueryClientProvider } from "@tanstack/react-query";
import { queryClient } from "@/lib/queryClient";
import { register } from "@/services/register";
import { useRouter } from "next/navigation";

const VisuallyHiddenInput = styled("input")({
  clip: "rect(0 0 0 0)",
  clipPath: "inset(50%)",
  height: 1,
  overflow: "hidden",
  position: "absolute",
  bottom: 0,
  left: 0,
  whiteSpace: "nowrap",
  width: 1,
});

export default function CreateAccountPage() {
  const router = useRouter()
  const [image, setImage] = useState<string | null>(null);
  const [createAccountData, setCreateAccountData] =
    useState<CreateAccountFormData>({
      username: "",
      email: "",
      password: "",
      confirmPassword: "",
      profilePicture: null,
    });
  const [formSubmtionLoading, setFormSubmtionLoading] = useState(false);
  const fileInputRef = useRef(null);

  const handleIconButtonClick = () => {
    //@ts-ignore
    fileInputRef.current.click();
  };

  const SmallAvatar = styled(Avatar)(({ theme }) => ({
    width: 32,
    height: 32,
    border: `2px solid ${theme.palette.background.paper}`,
  }));
  function handleFileChange(event: React.ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    if (file) {
      const url = URL.createObjectURL(file);
      setImage(url);
    }
  }
  function handleFormChange(event: React.ChangeEvent<HTMLInputElement>) {
    const { name, value } = event.target;
    setCreateAccountData((prev) => ({
      ...prev,
      [name]: value,
    }));
    console.log(createAccountData);
  }
  function handleFormSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setFormSubmtionLoading(true);
    register({
      email: createAccountData.email,
      password: createAccountData.password,
      username: createAccountData.username,
      profilePicture: image,
    })
      .then((serviceResponse) => {
        if(serviceResponse.status === 201) {
          router.push('/login')
        }
        else{
          alert(serviceResponse.response.message)
        }
      })
      .catch((error) => {
        alert("An error occurred while creating your account");
       })
      .finally(() => {
        setFormSubmtionLoading(false);
      });
  }
  const passwordMatch =
    createAccountData.password === createAccountData.confirmPassword;

  return (
    <>
      <QueryClientProvider client={queryClient}>
        <BackButton to="/" />
        <Container maxWidth="md">
          <Box>
            <Typography variant="h6" gutterBottom>
              Create Account
            </Typography>
            <Typography variant="body1" gutterBottom>
              An account is required to use this app
            </Typography>
          </Box>
          <Box>
            <IconButton
              tabIndex={-1}
              onClick={handleIconButtonClick}
              sx={{
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
                width: "100px",
                height: "100px",
                margin: "0 auto",
                marginBottom: "1rem",
              }}
            >
              <VisuallyHiddenInput
                ref={fileInputRef}
                onChange={handleFileChange}
                type="file"
              />
              <Badge
                sx={{
                  width: "100%",
                  height: "100%",
                }}
                overlap="circular"
                anchorOrigin={{ vertical: "bottom", horizontal: "right" }}
                badgeContent={
                  <SmallAvatar alt="Pencil">
                    <CreateIcon fontSize="small" />
                  </SmallAvatar>
                }
              >
                <Avatar
                  src={image ? image : undefined}
                  sx={{
                    width: "100%",
                    height: "100%",
                  }}
                >
                  JH
                </Avatar>
              </Badge>
            </IconButton>
          </Box>
          <form onSubmit={handleFormSubmit}>
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
                label="Email"
                onChange={handleFormChange}
                name="email"
                required
              />
              <TextField
                variant="outlined"
                type="password"
                label="Password"
                name="password"
                onChange={handleFormChange}
                required
              />
              <TextField
                variant="outlined"
                type="password"
                label="Confirm Password"
                name="confirmPassword"
                onChange={handleFormChange}
                error={
                  !passwordMatch && createAccountData.confirmPassword.length > 0
                }
                helperText={
                  !passwordMatch && createAccountData.confirmPassword.length > 0
                    ? "Passwords do not match"
                    : ""
                }
                required
              />
              <Button variant="contained" type="submit" fullWidth startIcon={
                formSubmtionLoading ? <CircularProgress size={20} /> : null
              } >
                Create Account
              </Button>
            </Stack>
          </form>
        </Container>
      </QueryClientProvider>
    </>
  );
}

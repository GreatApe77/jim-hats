"use client"
import { Avatar, Box, Button, Container, IconButton, Typography, styled } from "@mui/material";
import KeyboardArrowLeftIcon from '@mui/icons-material/KeyboardArrowLeft';
import Badge from '@mui/material/Badge';
import CreateIcon from '@mui/icons-material/Create';
export default function CreateAccountPage() {
    const SmallAvatar = styled(Avatar)(({ theme }) => ({
        width: 32,
        height: 32,
        border: `2px solid ${theme.palette.background.paper}`,
    }));
    return (
        <>
            <IconButton size="small">
                <KeyboardArrowLeftIcon />
            </IconButton>
            <Container maxWidth="md">
                <Box>
                    <Typography variant="h6" gutterBottom>Create Account</Typography>
                    <Typography variant="body1" gutterBottom>An account is required to use this app</Typography>
                </Box>
                <Box>
                    <IconButton sx={{
                        display: "flex",
                        justifyContent: "center",
                        alignItems: "center",
                        width: "100px",
                        height: "100px",


                        margin: "0 auto",
                        marginBottom: "1rem"
                    }} >
                        <Badge
                            sx={{
                                width: "100%",
                                height: "100%",
                            }}
                            overlap="circular"
                            anchorOrigin={{ vertical: 'bottom', horizontal: 'right' }}
                            badgeContent={
                                <SmallAvatar alt="Pencil"  >
                                    <CreateIcon fontSize="small" />
                                </SmallAvatar>
                            }
                        >
                            <Avatar src=""
                                sx={{
                                    width: "100%",
                                    height: "100%",
                                }} >
                                JH
                            </Avatar>
                        </Badge>
                    </IconButton>
                </Box>

            </Container>

        </>
    );
}
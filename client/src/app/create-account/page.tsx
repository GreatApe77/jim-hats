"use client"
import { Avatar, Box, Button, Container, IconButton, Stack, TextField, Typography, styled } from "@mui/material";
import KeyboardArrowLeftIcon from '@mui/icons-material/KeyboardArrowLeft';
import Badge from '@mui/material/Badge';
import CreateIcon from '@mui/icons-material/Create';
import { useRef, useState } from 'react';
import Link from "next/link";

const VisuallyHiddenInput = styled('input')({
    clip: 'rect(0 0 0 0)',
    clipPath: 'inset(50%)',
    height: 1,
    overflow: 'hidden',
    position: 'absolute',
    bottom: 0,
    left: 0,
    whiteSpace: 'nowrap',
    width: 1,
});

export default function CreateAccountPage() {
    const [image, setImage] = useState<string | null>(null)
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
            const url = URL.createObjectURL(file)
            setImage(url)
        }
    }

    return (
        <>
            <IconButton size="small" LinkComponent={Link} href="/">
                <KeyboardArrowLeftIcon />
            </IconButton>
            <Container maxWidth="md">
                <Box>
                    <Typography variant="h6" gutterBottom>Create Account</Typography>
                    <Typography variant="body1" gutterBottom>An account is required to use this app</Typography>
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
                            marginBottom: "1rem"
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
                            anchorOrigin={{ vertical: 'bottom', horizontal: 'right' }}
                            badgeContent={
                                <SmallAvatar alt="Pencil">
                                    <CreateIcon fontSize="small" />
                                </SmallAvatar>
                            }
                        >
                            <Avatar src={image?image:undefined}
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
                <Stack spacing={2}>
                    <TextField variant="outlined" label="Username" />
                    <TextField variant="outlined" label="Email" />
                    <TextField variant="outlined" type="password" label="Password" />
                    <TextField variant="outlined" type="password" label="Confirm Password" />
                    <Button variant="contained" fullWidth>Create Account</Button>
                </Stack>
            </Container>
        </>
    );
}

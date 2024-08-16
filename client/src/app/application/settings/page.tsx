"use client";
import MainDrawer from "@/components/MainDrawer";
import { useChallengesOfUser } from "@/hooks/useChallengesOfUser";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import EmailOutlinedIcon from "@mui/icons-material/EmailOutlined";
import KeyOutlinedIcon from "@mui/icons-material/KeyOutlined";
import PersonOutlinedIcon from "@mui/icons-material/PersonOutlined";
import CloseIcon from "@mui/icons-material/Close";
import {
  AppBar,
  Avatar,
  Button,
  Container,
  Dialog,
  Divider,
  IconButton,
  List,
  ListItem,
  ListItemAvatar,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  Slide,
  Toolbar,
  Typography,
} from "@mui/material";
import { TransitionProps } from "@mui/material/transitions";
import { useRouter } from "next/navigation";
import React from "react";
import ImageOutlinedIcon from '@mui/icons-material/ImageOutlined';
export default function SettingsPage() {
  const { data: response } = useLoggedUser();
  const [open, setOpen] = React.useState(false);
  const router = useRouter();
  const { data: gymChallengesResponse } = useChallengesOfUser();
  const user = response?.response.data;
  const challenges = gymChallengesResponse?.response.data?.map((challenge) => {
    return {
      ...challenge,
      id: challenge.id.toString(),
    };
  });
  return (
    <>
      <MainDrawer user={user} challenges={challenges} />
      <Container maxWidth="md">
        <Typography variant="h5" gutterBottom>
          Settings
        </Typography>
        <Typography variant="body1">General</Typography>
        <List>
          <ListItem disablePadding>
            <ListItemButton disableGutters
                onClick={()=>{
                    setOpen(true)
                }}
            >
              <ListItemAvatar>
                <Avatar src={user?.profilePicture!}>{user?.username[0]}</Avatar>
              </ListItemAvatar>
              <ListItemText primary="Change profile picture" />
            </ListItemButton>
          </ListItem>

          <ListItem disablePadding>
            <ListItemButton
              disableGutters
              onClick={() => router.push("/application/settings/change-name")}
            >
              <ListItemAvatar>
                <Avatar>
                  <PersonOutlinedIcon />
                </Avatar>
              </ListItemAvatar>
              <ListItemText primary="Name" secondary={user?.username} />
            </ListItemButton>
          </ListItem>
          <ListItem disablePadding>
            <ListItemButton
              disableGutters
              onClick={() => router.push("/application/settings/change-email")}
            >
              <ListItemAvatar>
                <Avatar>
                  <EmailOutlinedIcon />
                </Avatar>
              </ListItemAvatar>
              <ListItemText primary="Email" secondary={user?.email} />
            </ListItemButton>
          </ListItem>
          <ListItem disablePadding>
            <ListItemButton
              disableGutters
              onClick={() =>
                router.push("/application/settings/change-password")
              }
            >
              <ListItemAvatar>
                <Avatar>
                  <KeyOutlinedIcon />
                </Avatar>
              </ListItemAvatar>
              <ListItemText primary="Password" secondary="••••••••••••" />
            </ListItemButton>
          </ListItem>
        </List>
        <FullScreenDialog open={open} setOpen={setOpen} />
      </Container>
    </>
  );
}

const Transition = React.forwardRef(function Transition(
  props: TransitionProps & {
    children: React.ReactElement;
  },
  ref: React.Ref<unknown>,
) {
  return <Slide direction="up" ref={ref} {...props} />;
});

function FullScreenDialog({
  open,
  setOpen,
}: {
  open: boolean;
  setOpen: React.Dispatch<React.SetStateAction<boolean>>;
}) {
  

  const handleClose = () => {
    setOpen(false);
  };

  return (
    <React.Fragment>
      
      <Dialog
        fullScreen
        open={open}
        onClose={handleClose}
        TransitionComponent={Transition}
      >
        <AppBar sx={{ position: "relative" }}>
          <Toolbar>
            <IconButton
              edge="start"
              color="inherit"
              onClick={handleClose}
              aria-label="close"
            >
                <CloseIcon />
            </IconButton>
            <Typography sx={{ ml: 2, flex: 1 }} variant="h6" component="div">
              Photo selection
            </Typography>
            <Button autoFocus color="inherit" onClick={handleClose}>
              save
            </Button>
          </Toolbar>
        </AppBar>
        <List>
          <ListItemButton>
            <ListItemIcon>
                <ImageOutlinedIcon />
            </ListItemIcon>
            <ListItemText primary="Upload my own"  />
          </ListItemButton>
          <Divider />
          <ListItemButton >
            <ListItemIcon>
                <CloseIcon sx={{color:"red"}}  />
            </ListItemIcon>
            <ListItemText
                sx={{color:"red"}}
            
              primary="Remove photo"
              
              
            />
          </ListItemButton>
        </List>
      </Dialog>
    </React.Fragment>
  );
}

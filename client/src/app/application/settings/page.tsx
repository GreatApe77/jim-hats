"use client"
import MainDrawer from "@/components/MainDrawer";
import { useChallengesOfUser } from "@/hooks/useChallengesOfUser";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { Avatar, Container, List, ListItem, ListItemAvatar, ListItemButton, ListItemIcon, ListItemText, Typography } from "@mui/material";
import KeyOutlinedIcon from '@mui/icons-material/KeyOutlined';
import PersonOutlinedIcon from '@mui/icons-material/PersonOutlined';
import EmailOutlinedIcon from '@mui/icons-material/EmailOutlined';
import { useRouter } from "next/navigation";
export default function SettingsPage() {
    const { data: response } = useLoggedUser();
    const router = useRouter();
    const {data:gymChallengesResponse} = useChallengesOfUser();
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
        <Typography variant="body1">
            General
        </Typography>
        <List>
            <ListItem disablePadding>
                <ListItemButton disableGutters>
                    <ListItemAvatar>
                        <Avatar src={user?.profilePicture!}>
                            {user?.username[0]}
                        </Avatar>
                    </ListItemAvatar>
                    <ListItemText primary="Change profile picture"  />
                </ListItemButton>
            </ListItem>

            <ListItem disablePadding>
                <ListItemButton disableGutters
                    onClick={() => router.push('/application/settings/change-name')}
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
                <ListItemButton disableGutters
                    onClick={() => router.push('/application/settings/change-email')}
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
                <ListItemButton disableGutters
                
                    onClick={() => router.push('/application/settings/change-password')}
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
      </Container>
    </>
  );
}

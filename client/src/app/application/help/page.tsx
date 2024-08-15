"use client"
import MainDrawer from "@/components/MainDrawer";
import { EMAIL_TO, GITHUB_REPO_URL, LINKEDIN_URL } from "@/constants";
import { useChallengesOfUser } from "@/hooks/useChallengesOfUser";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import EmailIcon from "@mui/icons-material/Email";
import GitHubIcon from "@mui/icons-material/GitHub";
import LinkedInIcon from "@mui/icons-material/LinkedIn";
import {
  Container,
  List,
  ListItem,
  ListItemAvatar,
  ListItemButton,
  ListItemText,
  Typography,
} from "@mui/material";

export default function HelpPage() {
  const { data: response } = useLoggedUser();
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
      <MainDrawer 
      challenges={challenges}
      user={user}
      />
      <Container maxWidth="md">
        <Typography variant="h5" gutterBottom>
          Help & feedback
        </Typography>
        <List>
          <ListItem disablePadding >
          <ListItemButton  onClick={
            ()=>{
              window.open(GITHUB_REPO_URL)
            }
            }>
            <ListItemAvatar>
              <GitHubIcon />
            </ListItemAvatar>
            <ListItemText primary="Source Code" />
          </ListItemButton>
          </ListItem>
          <ListItem disablePadding>
          <ListItemButton onClick={
            ()=>{
              window.open(LINKEDIN_URL)
            }
          } >
            <ListItemAvatar>
              <LinkedInIcon />
            </ListItemAvatar>
            <ListItemText primary="My Linkedin" />
          </ListItemButton>
          </ListItem>
          <ListItem  disablePadding>
            <ListItemButton
              onClick={()=>{
                window.open(EMAIL_TO)
                  
              }}
            >
              <ListItemAvatar>
                <EmailIcon />
              </ListItemAvatar>
              <ListItemText
                primary="Mail me!"
                secondary="mateusnavarro9@gmail.com"
              />
            </ListItemButton>
          </ListItem>
        </List>
      </Container>
    </>
  );
}

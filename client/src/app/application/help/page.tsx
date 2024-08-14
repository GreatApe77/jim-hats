import MainDrawer from "@/components/MainDrawer";
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
  return (
    <>
      <MainDrawer />
      <Container>
        <Typography variant="h5" gutterBottom>
          Help & feedback
        </Typography>
        <List>
          <ListItem>
            <ListItemAvatar>
              <GitHubIcon />
            </ListItemAvatar>
            <ListItemText primary="Source Code" />
          </ListItem>
          <ListItem>
            <ListItemAvatar>
              <LinkedInIcon />
            </ListItemAvatar>
            <ListItemText primary="My Linkedin" />
          </ListItem>
          <ListItem >
            <ListItemButton >
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

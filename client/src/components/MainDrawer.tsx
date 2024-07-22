import Box from "@mui/material/Box";
import Divider from "@mui/material/Divider";
import Drawer from "@mui/material/Drawer";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemIcon from "@mui/material/ListItemIcon";
import ListItemText from "@mui/material/ListItemText";
import { useContext, useState } from "react";

import { CreateChallengeModalContext } from "@/contexts/CreateChallengeModalContext";
import AddCircleOutlineIcon from "@mui/icons-material/AddCircleOutline";
import FlagIcon from "@mui/icons-material/Flag";
import Groups3Icon from "@mui/icons-material/Groups3";
import HelpOutlineIcon from "@mui/icons-material/HelpOutline";
import InfoIcon from "@mui/icons-material/Info";
import MenuIcon from "@mui/icons-material/Menu";
import SettingsIcon from "@mui/icons-material/Settings";
import { Avatar, Icon, IconButton } from "@mui/material";
import CreateChallengeModal from "./CreateChallengeModal";
import { usePathname, useRouter } from "next/navigation";
type Props = {
  user?: {
    username: string;
    profilePicture: string | null;
  };
  children?: React.ReactNode;
  challenges?: {
    image: string | null;
    name: string;
    id: string;
  }[];
};
export default function MainDrawer({
  user = {
    username: "Jim",
    profilePicture: "ANY",
  },
  challenges = [
    {
      image: "https://www.google.com",
      name: "Challenge 1",
      id: "1",
    },
    {
      image: "https://www.google.com",
      name: "Challenge 2",
      id: "2",
    },
  ],
}: Props) {
  const [open, setOpen] = useState(false);
  const router = useRouter()
  const modalContext = useContext(CreateChallengeModalContext);
  const pathName = usePathname()
  const toggleDrawer = (newOpen: boolean) => () => {
    setOpen(newOpen);
  };
  function openModal() {
    console.log(modalContext);
    modalContext?.setOpen(true);
  }
  const DrawerList = (
    <Box sx={{ width: 250 }} role="presentation" onClick={toggleDrawer(false)}>
      <List>
        <ListItem disablePadding>
          <ListItemButton selected={pathName==="/application/checkins"}
          onClick={()=>{
            router.push("/application/checkins")
          }}>
            <ListItemIcon>
              <Avatar
                alt={user.username}
                src={user.profilePicture || undefined}
              />
            </ListItemIcon>
            <ListItemText  primary={user.username} />
          </ListItemButton>
        </ListItem>
      </List>
      <Divider />
      <List>
        {challenges.map((challenge, index) => (
          <ListItem key={challenge.name} disablePadding >
            <ListItemButton selected={pathName===`/application/challenges/${challenge.id}`} 
            onClick={()=>{
              router.push(`/application/challenges/${challenge.id}`)
            }}
            >
              <ListItemIcon>
                <Avatar
                  sx={{ height: 36, width: 36 }}
                  alt={challenge.name}
                  src={challenge.image || challenge.name}
                />
              </ListItemIcon>
              <ListItemText primary={challenge.name} />
            </ListItemButton>
          </ListItem>
        ))}
      </List>
      <Divider />
      <List>
        <ListItem disablePadding>
          <ListItemButton onClick={openModal}>
            <ListItemIcon>
              <AddCircleOutlineIcon />
            </ListItemIcon>
            <ListItemText primary="Create challenge" />
          </ListItemButton>
        </ListItem>
        <ListItem disablePadding>
          <ListItemButton>
            <ListItemIcon>
              <Groups3Icon />
            </ListItemIcon>
            <ListItemText primary="Join challenge" />
          </ListItemButton>
        </ListItem>
        <ListItem disablePadding>
          <ListItemButton>
            <ListItemIcon>
              <FlagIcon />
            </ListItemIcon>
            <ListItemText primary="Completed challenges" />
          </ListItemButton>
        </ListItem>
      </List>
      <Divider />
      <List>
        <ListItem disablePadding>
          <ListItemButton>
            <ListItemIcon>
              <SettingsIcon />
            </ListItemIcon>
            <ListItemText primary="Settings" />
          </ListItemButton>
        </ListItem>
        <ListItem disablePadding>
          <ListItemButton>
            <ListItemIcon>
              <HelpOutlineIcon />
            </ListItemIcon>
            <ListItemText primary="Help & Feedback" />
          </ListItemButton>
        </ListItem>
        <ListItem disablePadding>
          <ListItemButton>
            <ListItemIcon>
              <InfoIcon />
            </ListItemIcon>
            <ListItemText primary="About" />
          </ListItemButton>
        </ListItem>
      </List>
    </Box>
  );

  return (
    <div>
      <IconButton onClick={toggleDrawer(true)}>
        <Icon>
          <MenuIcon />
        </Icon>
      </IconButton>
      <Drawer open={open} onClose={toggleDrawer(false)}>
        {DrawerList}
      </Drawer>
      <CreateChallengeModal />
    </div>
  );
}

import { useState } from 'react';
import Box from '@mui/material/Box';
import Drawer from '@mui/material/Drawer';
import Button from '@mui/material/Button';
import List from '@mui/material/List';
import Divider from '@mui/material/Divider';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';

import AddCircleOutlineIcon from '@mui/icons-material/AddCircleOutline';
import Groups3Icon from '@mui/icons-material/Groups3';
import FlagIcon from '@mui/icons-material/Flag';
import { Avatar, Icon, IconButton } from '@mui/material';
import MenuIcon from '@mui/icons-material/Menu';
import SettingsIcon from '@mui/icons-material/Settings';
import HelpOutlineIcon from '@mui/icons-material/HelpOutline';
import InfoIcon from '@mui/icons-material/Info';
type Props = {
    user?: {
        username: string,
        profilePicture: string | null
    },
    children?: React.ReactNode
    challenges?: {
        image: string | null,
        name: string
    }[]

}
export default function TemporaryDrawer({ user = {
    username: "Jim",
    profilePicture: "ANY"
},
    challenges = [
        {
            image: "https://www.google.com",
            name: "Challenge 1"
        },
        {
            image: "https://www.google.com",
            name: "Challenge 2"
        }
    ]
}: Props) {
    const [open, setOpen] = useState(false);

    const toggleDrawer = (newOpen: boolean) => () => {
        setOpen(newOpen);
    };

    const DrawerList = (
        <Box sx={{ width: 250 }} role="presentation" onClick={toggleDrawer(false)}>
            <List>
                <ListItem disablePadding>
                    <ListItemButton>
                        <ListItemIcon>

                            <Avatar alt={user.username} src={user.profilePicture || undefined} />
                        </ListItemIcon>
                        <ListItemText primary={user.username} />
                    </ListItemButton>
                </ListItem>
            </List>
            <Divider />
            <List>

                {challenges.map((challenge, index) => (
                    <ListItem key={challenge.name} disablePadding>
                        <ListItemButton>
                            <ListItemIcon>
                                <Avatar sx={
                                    { height: 36, width: 36 }
                                } alt={challenge.name} src={challenge.image || challenge.name} />
                            </ListItemIcon>
                            <ListItemText primary={challenge.name} />
                        </ListItemButton>
                    </ListItem>
                ))}
            </List>
            <Divider />
            <List>
                <ListItem disablePadding>
                    <ListItemButton>
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
        </div>
    );
}
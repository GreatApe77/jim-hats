"use client";
import MainDrawer from "@/components/MainDrawer";
import { useChallengesOfUser } from "@/hooks/useChallengesOfUser";
import { useLoggedUser } from "@/hooks/useLoggedUser";
import { useUserLogs } from "@/hooks/useUserLogs";
import {
  Avatar,
  Badge,
  Box,
  Container,
  Stack,
  Typography,
} from "@mui/material";
import { DateCalendar, PickersDay, PickersDayProps } from "@mui/x-date-pickers";
import { Dayjs } from "dayjs";

export default function UserCheckinsPage() {
  const { data: gymChallengesResponse } = useChallengesOfUser();
  const { data: loggedUserResponse } = useLoggedUser();
  const user = loggedUserResponse?.response.data;
  const challenges = gymChallengesResponse?.response.data?.map((challenge) => {
    return {
      ...challenge,
      id: challenge.id.toString(),
    };
  });
  const { data: userLogsResponse } = useUserLogs();
  const userLogs = userLogsResponse?.response.data;
  return (
    <>
      <MainDrawer user={user} challenges={challenges} />
      <Container maxWidth="sm">
        <Stack
          spacing={1}
          sx={{
            alignItems: "center",
            width: "100%",
          }}
        >
          <Avatar
            sx={{ width: 56, height: 56 }}
            alt={user?.username}
            src={user?.profilePicture || undefined}
          />

          <Box sx={{textAlign:'center'}}>
            <Typography variant="h6">{user?.username}</Typography>
            <Typography variant="body1">
              {userLogs?.length} check-ins
            </Typography>
          </Box>
        </Stack>
          <Box>

        <DateCalendar
        
        slots={{
            day: ServerDay,
        }}
        slotProps={{
            day:{
                highlightedDays: userLogs?.map((log) => {
                    return new Date(log.date).getDate();
                }),
            }
        }}
        />
        </Box>
      </Container>
    </>
  );
}

function ServerDay(
  props: PickersDayProps<Dayjs> & { highlightedDays?: number[] },
) {
  const { highlightedDays = [], day, outsideCurrentMonth, ...other } = props;

  const isSelected =
    !props.outsideCurrentMonth &&
    highlightedDays.indexOf(props.day.date()) >= 0;

  return (
    <Badge
      key={props.day.toString()}
      overlap="circular"
      badgeContent={isSelected ? "🔴" : undefined}
    >
      <PickersDay
        {...other}
        outsideCurrentMonth={outsideCurrentMonth}
        day={day}
      />
    </Badge>
  );
}

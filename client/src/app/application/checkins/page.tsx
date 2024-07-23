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

  const highlightedDays = userLogs?.map((log) => ({
    day: new Date(log.date).getDate(),
    month: new Date(log.date).getMonth(),
    year: new Date(log.date).getFullYear(),
  }));

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

          <Box sx={{ textAlign: "center" }}>
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
              day: {
                highlightedDays: highlightedDays,
              } as any,
            }}
          />
        </Box>
      </Container>
    </>
  );
}

function ServerDay(
  props: PickersDayProps<Dayjs> & { highlightedDays?: { day: number, month: number, year: number }[] },
) {
  const { highlightedDays = [], day, outsideCurrentMonth, ...other } = props;

  const isSelected = highlightedDays.some(
    (highlightedDay) =>
      highlightedDay.day === day.date() &&
      highlightedDay.month === day.month() &&
      highlightedDay.year === day.year()
  );

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

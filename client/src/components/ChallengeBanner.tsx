import {
  Avatar,
  Card,
  CardContent,
  CardHeader,
  CardMedia,
  Stack,
  Typography,
} from "@mui/material";
import dayjs from "dayjs";
import CalendarMonthIcon from '@mui/icons-material/CalendarMonth';
export default function ChallengeBanner({
  challengeImage,
  endDate,
  you,
  leader,
}: {
  challengeImage?: string| null;
  endDate: string;
  you: {
    count: number;
    profilePicture?: string | null ;
  };
  leader: {
    count: number;
    profilePicture?: string | null;
  };
}) {
  return (
    <>
      <Card>
        <CardMedia
          component="img"
          height="194"
          image={challengeImage??"https://images.pexels.com/photos/3077882/pexels-photo-3077882.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"}
          alt="Challenge Image"
        />
        <CardContent
          sx={{
            padding: 0,
          }}
        >
          <Stack direction="row" justifyContent={"center"} spacing={0}>
            <CardHeader
              sx={{
                paddingX: 1,
              }}
              avatar={
                <Avatar
                  src={leader.profilePicture || ""}
                  alt="Leader"
                
                    sx={{
                        width: 36,
                        height: 36,
                    }}
                />
              }
              title={leader.count}
              subheader={<Typography variant="caption">
               Leader
              </Typography>}
            />

            <CardHeader
              sx={{
                paddingX: 1,
              }}
              avatar={
                <Avatar
                sx={{
                    width: 36,
                    height: 36,
                }}
                  src={you.profilePicture || ""}
                  alt="You"
                />
              }
              title={you.count}
              subheader={<Typography variant="caption">
                You
              </Typography>}
            />

            <CardHeader
              sx={{
                paddingX: 1,
              }}
              avatar={<Avatar alt="Remy Sharp" sx={{
                bgcolor:"inherit",
                color:"white",
                width: 36,
                height: 36,
              }}>
                <CalendarMonthIcon/>
              </Avatar>}
              title={dayjs(endDate).diff(dayjs(), "day")}
              subheader={<Typography variant="caption">
                days left
              </Typography>}
            />
          </Stack>
        </CardContent>
      </Card>
    </>
  );
}

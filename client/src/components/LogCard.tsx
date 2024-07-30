import { Avatar, Card, CardHeader, Stack, Typography } from "@mui/material";
import dayjs from "dayjs";

export default function LogCard({
  logImage,
  logTitle,
  logDate,
  usernameProfilePic,
  username,
  
}: {
  logImage: string;
  logTitle: string;
  logDate: string;
  usernameProfilePic?: string | null;
  username: string;
}) {
  const formatedTime = dayjs(logDate).format("HH:mm");
  return (
    <>
      <Card>
        <CardHeader
          avatar={<Avatar alt={logTitle} src={logImage || undefined} />}
          title={logTitle}
          subheader={
            <>
              <Stack direction="row" justifyContent={"space-between"}>
                <Stack direction="row" spacing={1}>
                  <Avatar
                    sx={{
                      width: 20,
                      height: 20,
                    }}
                    
                    src={usernameProfilePic || undefined}
                    
                  >
                    
                    {username?.length?
                      <>
                        <Typography variant="body2">
                          {username[0].toUpperCase()}
                        </Typography>
                      </>
                    :""}
                  </Avatar>

                  <Typography variant="body2">{username}</Typography>
                  
                </Stack>
                <Typography
                    
                    variant="body2"
                    component={"span"}
                  >
                    {formatedTime}{" "}
                  </Typography>
              </Stack>
            </>
          }
        />
      </Card>
    </>
  );
}

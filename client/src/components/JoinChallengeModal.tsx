"use client";
import { JoinChallengeModalContext } from "@/contexts/JoinChallengeModalContext";
import { joinChallenge } from "@/services/join-challenge";
import {
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  Stack,
  TextField,
} from "@mui/material";
import Button from "@mui/material/Button";
import { useRouter } from "next/navigation";
import { useContext, useState } from "react";
import { validate } from "uuid";
export default function JoinChallengeModal() {
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  //const [banner, setBanner] = useState<File | null>(null);
  const [challengeIdInputValue, setChallengeIdInputValue] = useState("");
  function handleFormChange(event: React.ChangeEvent<HTMLInputElement>) {
    const { value } = event.target;
    setChallengeIdInputValue(value);
  }
  const context = useContext(JoinChallengeModalContext);

  function handleClose() {
    context?.setOpen(false);
  }
  const validChallengeId = validate(challengeIdInputValue);
  return (
    <>
      <Dialog
        open={context?.open!}
        fullScreen
        onClose={handleClose}
        PaperProps={{
          component: "form",
          onSubmit: (event: React.FormEvent<HTMLFormElement>) => {
            event.preventDefault();
            setLoading(true);
            const token = localStorage.getItem("token");
            const errorMsgIfFailed = "An error occured while joining challenge";
            if (!token) {
              return router.push("/login");
            }
            if (!validChallengeId) {
              return;
            }
            joinChallenge(challengeIdInputValue, token)
              .then((response) => {
                if (response.success) {
                  window.location.reload();
                } else {
                  alert(response.response.message);
                }
              })
              .catch(() => {
                alert(errorMsgIfFailed);
              })
              .finally(() => {
                setLoading(false);
              });
          },
        }}
      >
        <DialogTitle>Join a Challenge!</DialogTitle>
        <DialogContent>
          <Stack spacing={1}>
            <TextField
              autoFocus
              required
              margin="dense"
              id="challengeId"
              name="challengeId"
              label="Challenge Code"
              type="text"
              fullWidth
              variant="filled"
              value={challengeIdInputValue}
              onChange={handleFormChange}
              error={!validChallengeId && challengeIdInputValue.length > 0}
            />
          </Stack>
        </DialogContent>

        <DialogActions>
          <Button onClick={handleClose}>Cancel</Button>
          <Button variant="contained" type="submit" disabled={loading}>
            {loading ? "Joining..." : "Join"}
          </Button>
        </DialogActions>
      </Dialog>
    </>
  );
}

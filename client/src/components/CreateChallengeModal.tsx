"use client";
import { CreateChallengeModalContext } from "@/contexts/CreateChallengeModalContext";
import ArrowRightAltIcon from "@mui/icons-material/ArrowRightAlt";
import ImageIcon from "@mui/icons-material/Image";
import {
  Box,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  Stack,
  TextField,
  Typography,
} from "@mui/material";
import Button from "@mui/material/Button";
import { useContext, useState } from "react";
import { VisuallyHiddenInput } from "./VisuallyHiddenInput";
export default function CreateChallengeModal() {
  const [banner, setBanner] = useState<File | null>(null);

  const context = useContext(CreateChallengeModalContext);

  function handleClose() {
    context?.setOpen(false);
  }
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
            const formData = new FormData(event.currentTarget);
            const formJson = Object.fromEntries((formData as any).entries());
            const email = formJson.email;
            console.log(email);
            handleClose();
          },
        }}
      >
        <DialogTitle>Create a Gym Challenge!</DialogTitle>
        <DialogContent>
          <Stack spacing={1}>
            <TextField
              autoFocus
              required
              margin="dense"
              id="name"
              name="email"
              label="Challenge Title"
              type="text"
              fullWidth
              variant="standard"
            />
            <TextField
              autoFocus
              required
              margin="dense"
              id="name"
              name="description"
              label="Describe the challenge"
              type="text"
              fullWidth
              variant="standard"
              multiline
            />
            <Stack spacing={2} direction={"row"} sx={{ alignItems: "center" }}>
              <TextField
                autoFocus
                required
                margin="dense"
                id="name"
                name="startAt"
                size="small"
                type="date"
                variant="standard"
                helperText="When does the challenge start?"
              />
              <ArrowRightAltIcon />
              <TextField
                autoFocus
                required
                margin="dense"
                id="name"
                name="endAt"
                type="date"
                size="small"
                variant="standard"
                helperText="When does the challenge end?"
                onChange={(event) => {
                  console.log(event.target.value);
                }}
              />
            </Stack>
            <Stack direction={"column"} spacing={1}>
              <Button
                size="small"
                component="label"
                variant="outlined"
                startIcon={<ImageIcon />}
              >
                Choose a Banner
                <VisuallyHiddenInput
                  type="file"
                  onChange={(event) => {
                    const file = event.target.files?.[0];
                    if (file) {
                      setBanner(file);
                    }
                  }}
                />
              </Button>

              {banner && (
                <>
                  {/* eslint-disable-next-line @next/next/no-img-element */}
                  
                    <img
                      src={URL.createObjectURL(banner)}
                      alt=""
                      style={{objectFit:"contain"}}
                    />
                  
                  <Typography variant="caption">{banner.name}</Typography>
                </>
              )}
            </Stack>
          </Stack>
        </DialogContent>

        <DialogActions>
          <Button onClick={handleClose}>Cancel</Button>
          <Button variant="contained" type="submit">
            Submit New Challenge
          </Button>
        </DialogActions>
      </Dialog>
    </>
  );
}

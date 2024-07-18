"use client";
import { CreateChallengeModalContext } from "@/contexts/CreateChallengeModalContext";
import {
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  TextField,
} from "@mui/material";
import Button from "@mui/material/Button";
import { useContext } from "react";

export default function CreateChallengeModal() {
  const context = useContext(CreateChallengeModalContext);
  function handleClose() {
    context?.setOpen(false);
  }
  return (
    <>
      <Dialog
        open={context?.open!}
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
          DATAS(CAlendario)...
          <p>Input de foto</p>
        </DialogContent>

        <DialogActions>
          <Button onClick={handleClose}>Cancel</Button>
          <Button type="submit">Subscribe</Button>
        </DialogActions>
      </Dialog>
    </>
  );
}

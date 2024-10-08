"use client";
import { CreateChallengeModalContext } from "@/contexts/CreateChallengeModalContext";
import { createChallenge } from "@/services/create-challenge";
import { uploadGymChallengeBanner } from "@/services/upload-gym-challenge-banner";
import { CreateChallengeFormData } from "@/types";
import ArrowRightAltIcon from "@mui/icons-material/ArrowRightAlt";
import ImageIcon from "@mui/icons-material/Image";
import {
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  Stack,
  TextField,
  Typography,
} from "@mui/material";
import Button from "@mui/material/Button";
import dayjs from "dayjs";
import { useRouter } from "next/navigation";
import { useContext, useState } from "react";
import { VisuallyHiddenInput } from "./VisuallyHiddenInput";
export default function CreateChallengeModal() {
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [banner, setBanner] = useState<File | null>(null);
  const [formData, setFormData] = useState<CreateChallengeFormData>({
    description: null,
    endAt: "",
    startAt: "",
    image: null,
    name: "",
  });
  function handleFormChange(event: React.ChangeEvent<HTMLInputElement>) {
    const { name, value } = event.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  }
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
            setLoading(true);
            const token = localStorage.getItem("token");
            const errorMsgIfFailed =
              "An error occured while creating challenge";
            if (!token) {
              return router.push("/login");
            }
            if (banner) {
              uploadGymChallengeBanner(banner)
                .then((url) => {
                  createChallenge({ ...formData, image: url }, token)
                    .then((response) => {
                      if (response.status !== 201) {
                        return alert("Error creating challenge");
                      }
                      alert(response.response.message);
                      window.location.reload();
                    })
                    .catch((error) => {
                      alert(errorMsgIfFailed);
                    })
                    .finally(() => {
                      setLoading(false);
                    });
                })
                .catch((error) => {
                  alert(errorMsgIfFailed);
                });
            } else {
              //console.log(formData);
              createChallenge(formData, token)
                .then((response) => {
                  if (response.status !== 201) {
                    return alert("Error creating challenge");
                  }
                  alert(response.response.message);
                  window.location.reload();
                })
                .catch((error) => {
                  alert("An error occured");
                })
                .finally(() => {
                  setLoading(false);
                });
            }
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
              name="name"
              label="Challenge Title"
              type="text"
              fullWidth
              variant="standard"
              onChange={handleFormChange}
            />
            <TextField
              autoFocus
              margin="dense"
              id="name"
              name="description"
              label="Describe the challenge"
              type="text"
              fullWidth
              variant="standard"
              multiline
              onChange={handleFormChange}
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
                onChange={(event) => {
                  setFormData((prev) => ({
                    ...prev,
                    startAt: dayjs(event.target.value).format("DD/MM/YYYY"),
                  }));
                }}
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
                  setFormData((prev) => ({
                    ...prev,
                    endAt: dayjs(event.target.value).format("DD/MM/YYYY"),
                  }));
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
                  accept="image/*"
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
                    style={{ objectFit: "contain" }}
                  />

                  <Typography variant="caption">{banner.name}</Typography>
                </>
              )}
            </Stack>
          </Stack>
        </DialogContent>

        <DialogActions>
          <Button onClick={handleClose}>Cancel</Button>
          <Button variant="contained" type="submit" disabled={loading}>
            
            {loading ? "submiting..." : "submit new challenge"}
          </Button>
        </DialogActions>
      </Dialog>
    </>
  );
}

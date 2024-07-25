import { ExercisePictureContext } from "@/contexts/ExercisePictureContext";
import {
  Button,
  CircularProgress,
  Dialog,
  DialogContent,
  DialogTitle,
  Stack,
  TextField,
} from "@mui/material";
import { useContext, useState } from "react";

import { ExerciseModalContext } from "@/contexts/ExerciseModalContext";
import { logExercise } from "@/services/log-exercise";
import { uploadExercisePic } from "@/services/upload-exercise-picture";
import { CreateExerciseLogFormData } from "@/types";
import { useParams,useRouter } from "next/navigation";

import BackButtonGeneric from "./BackButtonGeneric";

export default function LogExerciseModal() {
  const [loading, setLoading] = useState(false);
  const params = useParams();
  const router = useRouter();
  const challengeId = params.id as string;
  const [formData, setFormData] = useState<CreateExerciseLogFormData>({
    title: "",
    description: "",
    image: "",
  });
  const exercisePicContext = useContext(ExercisePictureContext);
  const exerciseModalContext = useContext(ExerciseModalContext);
  function handleFormChange(event: React.ChangeEvent<HTMLInputElement>) {
    setFormData((prev) => {
      return {
        ...prev,
        [event.target.name]: event.target.value,
      };
    });
  }
  return (
    <Dialog
      fullScreen
      PaperProps={{
        component: "form",
        onSubmit: (event: React.FormEvent<HTMLFormElement>) => {
          event.preventDefault();
          setLoading(true);
          const token = localStorage.getItem("token");
          if (!token) {
            return;
          }
          if (exercisePicContext?.exercisePictureFile) {
            uploadExercisePic(exercisePicContext.exercisePictureFile)
              .then((uploadedUrl) => {
                logExercise(challengeId, token, {
                  ...formData,
                  image: uploadedUrl,
                })
                  .then((response) => {
                    if (response.status === 201) {
                      return window.location.reload()
                    } else {
                      alert("Error logging exercise");
                    }
                  })
                  .finally(() => {
                    setLoading(false);
                  });
              })
              .catch((error) => {
                alert("Error uploading picture");
                setLoading(false);
              });
          }
        },
      }}
      open={exerciseModalContext?.open!}
    >
      <DialogTitle
        sx={{
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
        }}
      >
        <BackButtonGeneric
          onClick={() => exerciseModalContext?.setOpen(false)}
        />
        <>New check-in</>
        {loading ? (
          <CircularProgress size={24} />
        ) : (
          <Button
            variant="contained"
            color="primary"
            type="submit"
            size="small"
          >
            Post
          </Button>
        )}
      </DialogTitle>
      <DialogContent>
        <Stack spacing={2} mt={1}>
          <TextField
            fullWidth
            label="Title"
            name="title"
            required
            onChange={handleFormChange}
          />

          <TextField
            fullWidth
            label="Description (optional)"
            name="description"
            multiline
            rows={4}
            onChange={handleFormChange}
          />

          <Button
            variant="contained"
            color="primary"
            component="label"
            size="small"
          >
            Change Picture
          </Button>
          {exercisePicContext?.exercisePictureFile && (
            <>
              <img
                src={URL.createObjectURL(
                  exercisePicContext.exercisePictureFile,
                )}
                alt="exercise"
                style={{ objectFit: "contain", borderRadius: "8px" }}
              />
            </>
          )}
        </Stack>
      </DialogContent>
    </Dialog>
  );
}

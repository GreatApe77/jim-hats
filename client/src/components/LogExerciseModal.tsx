import { ExercisePictureContext } from "@/contexts/ExercisePictureContext";
import {
  Button,
  Dialog,
  DialogContent,
  DialogTitle,
  Stack,
  TextField,
} from "@mui/material";
import { useContext } from "react";
import BackButton from "./BackButton";
import { ExerciseModalContext } from "@/contexts/ExerciseModalContext";
import BackButtonGeneric from "./BackButtonGeneric";

export default function LogExerciseModal() {
  const exercisePicContext = useContext(ExercisePictureContext);
  const exerciseModalContext = useContext(ExerciseModalContext)
  return (
    <Dialog
      fullScreen
      PaperProps={{
        component: "form",
        onSubmit: (event: React.FormEvent<HTMLFormElement>) => {
          event.preventDefault();
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
        <BackButtonGeneric onClick={()=>exerciseModalContext?.setOpen(false)} />
        <>Create a Gym Challenge!</>
        <Button variant="contained" color="primary" type="submit" size="small">
          Post
        </Button>
      </DialogTitle>
      <DialogContent>
        <Stack spacing={2} mt={1}>
          <TextField fullWidth label="Title" name="title" required />

          <TextField
            fullWidth
            label="Description (optional)"
            name="description"
            multiline
            rows={4}
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
                src={URL.createObjectURL(exercisePicContext.exercisePictureFile)}
                alt="exercise"
                style={{ objectFit: "contain",borderRadius:"8px" }}

                />
            </>
          )}
        </Stack>
      </DialogContent>
    </Dialog>
  );
}

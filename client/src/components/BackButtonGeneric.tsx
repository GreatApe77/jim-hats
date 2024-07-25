import KeyboardArrowLeftIcon from "@mui/icons-material/KeyboardArrowLeft";
import { IconButton } from "@mui/material";

type BackButtonProps = {
  onClick: () => void;
};
export default function BackButtonGeneric({ onClick }: BackButtonProps) {
  return (
    <IconButton size="small" onClick={onClick}>
      <KeyboardArrowLeftIcon />
    </IconButton>
  );
}

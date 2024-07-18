import KeyboardArrowLeftIcon from "@mui/icons-material/KeyboardArrowLeft";
import { IconButton } from "@mui/material";
import Link from "next/link";
type BackButtonProps = {
  to: string;
};
export default function BackButton({ to }: BackButtonProps) {
  return (
    <IconButton size="small" LinkComponent={Link} href={to}>
      <KeyboardArrowLeftIcon />
    </IconButton>
  );
}

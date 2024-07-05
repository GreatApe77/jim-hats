import { IconButton } from "@mui/material";
import Link from "next/link";
import KeyboardArrowLeftIcon from "@mui/icons-material/KeyboardArrowLeft";
type BackButtonProps = {
    to: string;
}
export default function BackButton({ to }: BackButtonProps) {
    return (
        <IconButton size="small" LinkComponent={Link} href={to}>
            <KeyboardArrowLeftIcon />
        </IconButton>
    )
}
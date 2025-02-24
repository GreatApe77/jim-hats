import multer from "multer";
import "dotenv/config";
import { successResponse } from "../utils/success-response.js";
import { MESSAGES } from "../messages.js";
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "public/uploads");
    },
    filename: (req, file, cb) => {
        const fileName = `${Date.now()}-${file.originalname}`;
        cb(null, fileName);
        const fullPath = `${process.env.BASE_URL}/uploads/${fileName}`;
        req.body.fullPath = fullPath;
    },
});

const upload = multer({
    storage: storage,
    fileFilter: (req, file, cb) => {
        //png or jpeg
        if (file.mimetype === "image/png" || file.mimetype === "image/jpeg") {
            cb(null, true);
        } else {
            //custom error message how to send in the reponse?

            cb(new Error(`file type ${file.mimetype} is not supported`));
        }
    },
});

export const uploadPhoto = upload.single("file");
/**
 * 
 * @param {import("express").Request} req 
 * @param {import("express").Response} res 
 * @returns 
 */
export function uploadController(req, res) {
    const fullPath = req.body.fullPath
    return res.status(200).json(successResponse(MESSAGES.CREATED, { fullPath }))
}
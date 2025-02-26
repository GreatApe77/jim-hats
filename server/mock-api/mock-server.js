/* eslint-disable no-undef */
/* eslint-disable @typescript-eslint/no-unused-vars */
import express from "express";
import morgan from "morgan";
import multer from "multer";
import "dotenv/config";
import { router } from "./router.js";
const PORT = process.env.PORT || 3000;
const app = express();
app.use(morgan("tiny"));
app.use(express.json());

app.use(express.static("public"));

app.use(router);

// Start the server
app.listen(PORT, () => {

    console.log(`Mock API server running on port ${PORT}`);
});
import express from "express";
import morgan from "morgan";
import cors from "cors"
import { router } from "./router.js";
import { environment } from "./config/environment.js";

const app = express();

app.use(cors({
    origin: environment.CLIENT_URL
}))
app.use(express.json());
app.use(morgan("tiny"));

app.use(router);

export { app };

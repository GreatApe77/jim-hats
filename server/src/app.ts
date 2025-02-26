import cors from "cors";
import express from "express";
import morgan from "morgan";
import { router } from "./router.js";

const app = express();
app.use(express.static("public"));
app.use(
  cors(),
);
app.use(express.json());
app.use(morgan("tiny"));

app.use(router);

export { app };

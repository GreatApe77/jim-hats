import { app } from "./app.js";
import { environment } from "./config/environment.js";
import "./container.js";

async function main() {
  app.listen(Number(environment.PORT),"0.0.0.0", () => {
    console.log(`Server is running on ${environment.PORT}`);
  });
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});

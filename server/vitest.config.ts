import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    //exclude: ["**/__mocks__/**"],
    coverage:{
      exclude:["**/__mocks__/**"]
    }
  },
});

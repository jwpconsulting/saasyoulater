import { devices } from "@playwright/test";
import type { PlaywrightTestConfig } from "@playwright/test";

const config: PlaywrightTestConfig = {
  webServer: {
    command: "npm run build && npm run preview -- --port 4173",
    port: 4173,
  },
  testDir: "tests",
  testMatch: /(.+\.)?(test|spec)\.[jt]s/,
  projects: [
    {
      name: "firefox",
      use: { ...devices["Desktop Firefox"] },
    },
  ],
};

export default config;

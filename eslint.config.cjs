const eslint = require("@eslint/js");
const tseslint = require("@typescript-eslint/eslint-plugin");
const tsparser = require("@typescript-eslint/parser");
const sveltePlugin = require("eslint-plugin-svelte");
const svelteParser = require("svelte-eslint-parser");
const prettierConfig = require("eslint-config-prettier");
const globals = require("globals");

/** @type { import("eslint").Linter.FlatConfig[] } */
module.exports = [
  {
    ignores: ["node_modules", "build", ".svelte-kit"],
  },
  eslint.configs.recommended,
  {
    files: ["**/*.js", "**/*.ts", "**/*.svelte"],
    plugins: {
      "@typescript-eslint": tseslint,
    },
    languageOptions: {
      parser: tsparser,
      parserOptions: {
        sourceType: "module",
        ecmaVersion: 2020,
      },
      globals: {
        ...globals.browser,
        ...globals.es2017,
        ...globals.node,
      },
    },
    rules: {
      ...tseslint.configs.recommended.rules,
    },
  },
  {
    files: ["**/*.svelte"],
    plugins: {
      svelte: sveltePlugin,
    },
    languageOptions: {
      parser: svelteParser,
      parserOptions: {
        parser: tsparser,
        extraFileExtensions: [".svelte"],
      },
    },
    rules: {
      ...sveltePlugin.configs.recommended.rules,
      "svelte/valid-compile": ["warn"],
    },
  },
  prettierConfig,
];

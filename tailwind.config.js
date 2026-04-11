/** @type {import('tailwindcss').Config} */
export default {
    content: ["./src/**/*.{html,js,svelte,ts}"],
    theme: {
        extend: {
            colors: {
                success: "#0f5132",
                warning: "#856404",
            },
        },
    },
    corePlugins: {
        preflight: false,
    },
    plugins: [],
};

import path from "path";
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { mochaPlugins } from "@getmocha/vite-plugins";
// Plugin Cloudflare comentado temporariamente devido a incompatibilidade de versão
// Descomente quando necessário para deploy em produção
// import { cloudflare } from "@cloudflare/vite-plugin";

export default defineConfig({
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    plugins: [
        ...mochaPlugins(process.env as any), 
        react(),
        // cloudflare() // Descomente para deploy em Cloudflare Workers
    ],
    server: {
        allowedHosts: true,
    },
    build: {
        chunkSizeWarningLimit: 5000,
    },
    resolve: {
        alias: {
            "@": path.resolve(__dirname, "./src"),
        },
    },
});
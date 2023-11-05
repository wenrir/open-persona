import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vitest/config';

export default defineConfig({
	plugins: [sveltekit()],
	test: {
		include: ['src/**/*.{test,spec}.{js,ts}'],
		enviroment: 'jsdom'
	},
	server: {
		strictPort: true,
		watch: {
			usePolling: process.env.USE_POLLING
		},
		hmr: {
			clientPort: 5050
		},
		host: '0.0.0.0',
		port: 5050
	}
});

// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	site: "https://charmfire.github.io",
  	base: "/fireplace",
	integrations: [
		starlight({
			title: 'Fireplace Docs',
			logo: {
				src: './src/assets/logo.png',
			},
			favicon: '/images/1f525.svg',
			social: [{ icon: 'github', label: 'GitHub', href: 'https://github.com/Charmfire/fireplace' }],
			sidebar: [
				{
					label: "Start Here",
					items: [
						{ label: "Who Is This Toolkit For?", slug: "start-here/intended-audience" },
						{ label: "A Few Words About Nix", slug: "start-here/few-words-about-nix" },					]
				},
				{
					label: "Guides",
					items: [
						{ label: "Starting A New Project", slug: "" },
						{ label: 'Local Testing', slug: 'guides/local-testing' },
						{ label: 'Continuous Deployment', slug: 'guides/local-testing' },
					]
				},
				{
					label: 'Tutorials',
					items: [
						// Each item here is one entry in the navigation menu.
						{ label: 'Creating an astro project', slug: 'tutorials/creating-astro-project' },
					],
				},	
				{
					label: 'Reference',
					autogenerate: { directory: 'reference' },
				},
			],
		}),
	],
});

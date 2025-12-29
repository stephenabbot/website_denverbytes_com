import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

export const collections = {
	work: defineCollection({
		// Load Markdown files in the src/content/work directory.
		loader: glob({ base: './src/content/work', pattern: '**/*.md' }),
		schema: z.object({
			title: z.string(),
			description: z.string(),
			publishDate: z.coerce.date(),
			tags: z.array(z.string()),
			img: z.string(),
			img_alt: z.string().optional(),
		}),
	}),
	blog: defineCollection({
		// Load Markdown files in the src/content/blog directory.
		loader: glob({ base: './src/content/blog', pattern: '**/*.md' }),
		schema: z.object({
			title: z.string(),
			description: z.string(),
			publishDate: z.coerce.date(),
			tags: z.array(z.string()),
			featured: z.boolean().optional(),
		}),
	}),
	experience: defineCollection({
		// Load Markdown files in the src/content/experience directory.
		loader: glob({ base: './src/content/experience', pattern: '**/*.md' }),
		schema: z.object({
			company: z.string(),
			role: z.string(),
			location: z.string(),
			startDate: z.coerce.date(),
			endDate: z.coerce.date().optional(),
			highlights: z.array(z.string()),
			order: z.number(),
		}),
	}),
};

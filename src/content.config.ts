import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const words = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/words' }),
  schema: z.object({
    title: z.string(),
    slug: z.string().optional(),
    date: z.coerce.date(),
    author: z.string().optional(),
    tags: z.string().optional(),
    draft: z.boolean().optional(),
  }),
});

export const collections = { words };

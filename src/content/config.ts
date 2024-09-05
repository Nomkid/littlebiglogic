import { z, defineCollection } from 'astro:content';

const misc = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
  }),
});

export const collections = {
  'misc': misc,
};

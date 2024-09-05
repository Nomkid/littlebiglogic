import { z, defineCollection } from 'astro:content';

const designs = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    creators: z.array(z.string()),
  }),
});
const misc = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
  }),
});

export const collections = {
  'designs': designs,
  'misc': misc,
};

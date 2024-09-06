import { z, defineCollection } from 'astro:content';

const designs = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    creators: z.array(z.string()),
    draft: z.optional(z.boolean()),
  }),
});
const misc = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    draft: z.optional(z.boolean()),
  }),
});

export const collections = {
  'designs': designs,
  'misc': misc,
};

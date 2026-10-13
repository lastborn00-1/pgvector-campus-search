# pgvector campus search (MLH GHW: Hacktoberfest)

A small vector database built on hosted Postgres with **pgvector**: 12 campus notices
(dining, library, transport, academics, events, weather, sports) stored as 8-dimensional
embeddings, searched with cosine distance.

- `build.sql` - schema + seed data, runnable on any Postgres with pgvector
- `TRANSCRIPT.md` - the live session: extension enabled, table loaded, real search results
- Live DB: Supabase project `pgvector-mlh` (free tier)

## Demo

```sql
select title, category,
       round((embedding <=> '[...]'::vector)::numeric, 4) as distance
from campus_notices
order by embedding <=> '[...]'::vector
limit 3;
```

Embeddings here are hashed bag-of-words vectors for the demo; swap in a real embedding
model (OpenAI, SentenceTransformers, etc.) and the same queries work unchanged.

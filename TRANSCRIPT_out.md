# pgvector campus search - live session transcript

Project: pgvector-mlh (Supabase free tier, hosted Postgres with pgvector)
Extension: `vector` (pgvector), enabled with `create extension if not exists vector`

## 1. Schema + seed (12 campus notices)

```sql
create extension if not exists vector;
create table campus_notices (
  id bigint generated always as identity primary key,
  title text not null,
  category text not null,
  source text not null,
  posted_at timestamptz not null default now(),
  content text not null,
  embedding vector(8) not null
);
-- 12 inserts across dining, library, transport, academics, events, weather, sports
```

Result:

```
[{"rows_loaded": 12}]
```

## 2. Semantic search demo (cosine distance)

Embeddings are hashed 8-dim bag-of-words vectors (demo-grade; production would use a
real embedding model). Same queries, unchanged, with real embeddings.

Query: "dining hall food and menu"
Embedding: [0.301511,0.301511,0.0,0.0,0.0,0.0,0.0,0.904534]

```sql
select title, category,
       round((embedding <=> '[0.301511,0.301511,0.0,0.0,0.0,0.0,0.0,0.904534]'::vector)::numeric, 4) as distance
from campus_notices
order by embedding <=> '[0.301511,0.301511,0.0,0.0,0.0,0.0,0.0,0.904534]'::vector
limit 3;
```

Result (top 3, nearest first):

| title | category | distance |
|---|---|---|
| Weekly dining hall menu | dining | 0.4719 |
| Gym renovation notice | sports | 0.5025 |
| Final exam timetable | academics | 0.5165 |

Query: "where can I eat dinner on campus"
Embedding: [0.516398,0.258199,0.0,0.0,0.0,0.258199,0.0,0.774597]

```sql
select title, category,
       round((embedding <=> '[0.516398,0.258199,0.0,0.0,0.0,0.258199,0.0,0.774597]'::vector)::numeric, 4) as distance
from campus_notices
order by embedding <=> '[0.516398,0.258199,0.0,0.0,0.0,0.258199,0.0,0.774597]'::vector
limit 3;
```

Result (top 3, nearest first):

| title | category | distance |
|---|---|---|
| Gym renovation notice | sports | 0.2694 |
| Weekly dining hall menu | dining | 0.2737 |
| Career fair | events | 0.4023 |

Query: "what time does the dining hall close for dinner"
Embedding: [0.0,0.179605,0.0,0.359211,0.0,0.0,0.179605,0.898027]

```sql
select title, category,
       round((embedding <=> '[0.0,0.179605,0.0,0.359211,0.0,0.0,0.179605,0.898027]'::vector)::numeric, 4) as distance
from campus_notices
order by embedding <=> '[0.0,0.179605,0.0,0.359211,0.0,0.0,0.179605,0.898027]'::vector
limit 3;
```

Result (top 3, nearest first):

| title | category | distance |
|---|---|---|
| Final exam timetable | academics | 0.3419 |
| Weekly dining hall menu | dining | 0.4721 |
| Library exam week 24 hour access | library | 0.6211 |


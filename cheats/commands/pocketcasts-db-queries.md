# Recent Listening History

```sql

SELECT p.title AS podcast_name, h.title AS episode_title, h.published
FROM listening_history h
INNER JOIN podcasts p
  ON h.podcast_uuid = p.uuid
ORDER by h.published DESC
LIMIT 20;

```

# Recent episodes flagged as favorites

```sql

SELECT p.title AS podcast_name, f.title AS episode_title, f.published
FROM favorites f
INNER JOIN podcasts p
  ON f.podcast_uuid = p.uuid
ORDER by f.published DESC
LIMIT 20;

```

# All Podcasts

```sql

SELECT uuid, title, author, imported_at
FROM podcasts
ORDER by title;

```

# Recent Sync Status

```sql

SELECT table_name, total_seen, new_added, started_at, finished_at
FROM sync_meta
ORDER by finished_at DESC
LIMIT 10;

```


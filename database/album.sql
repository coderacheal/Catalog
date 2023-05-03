CREATE TABLE album (
  id INTEGER PRIMARY KEY,
  source_id INTEGER,
  label_id INTEGER ,
  genre_id INTEGER REFERENCES genre(id),
  author_id INTEGER,
  published_date INTEGER,
  archived BOOLEAN,
  on_spotify BOOLEAN,
)

CREATE TABLE genre (
    id INTEGER PRIMARY,
    name VARCHAR,
)
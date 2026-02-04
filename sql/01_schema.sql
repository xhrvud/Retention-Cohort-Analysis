-- Table schema
CREATE TABLE IF NOT EXISTS events (
  event_time    timestamp,
  event_type    text,
  product_id    bigint,
  category_id   bigint,
  category_code text,
  brand         text,
  price         numeric,
  user_id       bigint,
  user_session  text
);

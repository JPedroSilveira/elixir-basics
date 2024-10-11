CREATE DATABASE lottery;

-- \c lottery;

-- CREATE TABLE users (
--     user_id BIGSERIAL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     email VARCHAR(255) UNIQUE NOT NULL
-- );

-- CREATE TABLE events (
--     event_id BIGSERIAL PRIMARY KEY,
--     user_id BIGINT NOT NULL REFERENCES users(user_id),
--     event_date DATE NOT NULL
-- );

-- CREATE TABLE event_participation (
--     event_id BIGINT NOT NULL REFERENCES events(event_id),
--     user_id BIGINT NOT NULL REFERENCES users(user_id),
--     PRIMARY KEY (event_id, user_id)
-- );
DROP TABLE IF EXISTS space_cowboy;

CREATE TABLE space_cowboy(

  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  bounty_value INT,
  danger_level VARCHAR(255)
);

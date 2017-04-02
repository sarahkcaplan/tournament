-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;

\c tournament;

CREATE TABLE players (id serial PRIMARY KEY, name text UNIQUE NOT NULL, created timestamp DEFAULT current_timestamp);

CREATE TABLE plays (id serial PRIMARY KEY, round integer NOT NULL, match integer UNIQUE NOT NULL);

CREATE TABLE matches (id serial PRIMARY KEY REFERENCES plays (match), player1 integer NOT NULL, player2 integer NOT NULL);

CREATE TABLE playsRecord (id serial PRIMARY KEY REFERENCES plays (id), winner integer NOT NULL, loser integer NOT NULL);


INSERT INTO players (name) VALUES ('Sarah');
INSERT INTO players (name) VALUES ('Ida');
INSERT INTO players (name) VALUES ('Ellen');
INSERT INTO players (name) VALUES ('Mikey');

INSERT INTO plays (round, match) VALUES (1, 1);
INSERT INTO plays (round, match) VALUES (1, 2);
INSERT INTO plays (round, match) VALUES (2, 3);
INSERT INTO plays (round, match) VALUES (2, 4);

INSERT INTO matches (player1, player2) VALUES (1, 2);
INSERT INTO matches (player1, player2) VALUES (3, 4);
INSERT INTO matches (player1, player2) VALUES (1, 3);
INSERT INTO matches (player1, player2) VALUES (2, 4);

INSERT INTO playsRecord (winner, loser) VALUES (1, 2);
INSERT INTO playsRecord (winner, loser) VALUES (3, 4);
INSERT INTO playsRecord (winner, loser) VALUES (3, 1);
INSERT INTO playsRecord (winner, loser) VALUES (4, 2);

# Join player id from matches with player name
SELECT players.id as player_id, players.name from players, matches where players.id = matches.player1;

# Count wins
# Can I make a view for this?
SELECT count(winner) FROM playsRecord where winner = %s; % n


# Count matches player1
SELECT players.id, count(matches.player1) FROM players, matches where players.id = matches.player1 GROUP BY players.id;
SELECT count(player1) FROM matches GROUP BY player1;

# Count matches player2
SELECT players.id, count(matches.player2) FROM players, matches where players.id = matches.player2 GROUP BY players.id;

# Create a view that lists id and sums up value of both count columns for player1, player2

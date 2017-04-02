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

INSERT INTO playsRecord (winner, loser) VALUES
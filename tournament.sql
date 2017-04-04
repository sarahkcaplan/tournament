-- Table definitions for the tournament project.

DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;

\c tournament;

CREATE TABLE players (id serial PRIMARY KEY, name text UNIQUE NOT NULL, created timestamp DEFAULT current_timestamp);

CREATE TABLE matches (id serial PRIMARY KEY, player1 integer NOT NULL, player2 integer NOT NULL);

CREATE TABLE playsRecord (id serial PRIMARY KEY, winner integer NOT NULL, loser integer NOT NULL);

CREATE VIEW player_name_id AS SELECT players.id as player_id, players.name from players LEFT JOIN matches ON players.id = matches.player1 or players.id = matches.player2 GROUP BY players.id ORDER BY player_id;

CREATE VIEW wins_count AS SELECT players.id as player_id, count(playsRecord.winner) as wins_count FROM players LEFT JOIN playsRecord ON players.id = playsRecord.winner GROUP BY players.id ORDER BY wins_count DESC;

CREATE VIEW players_matches_counts AS SELECT players.id as player_id, count(matches.player1) as matches_count, count(matches.player2) as matches_count_2 FROM players LEFT JOIN matches on players.id = matches.player1 or players.id = matches.player2 GROUP BY players.id ORDER BY player_id;

CREATE VIEW player_standings AS SELECT player_name_id.player_id as player_id, player_name_id.name as player_name, wins_count.wins_count, players_matches_counts.matches_count FROM player_name_id, wins_count, players_matches_counts WHERE player_name_id.player_id = wins_count.player_id and player_name_id.player_id = players_matches_counts.player_id ORDER BY wins_count DESC;

-- INSERT INTO players (name) VALUES ('Sarah');
-- INSERT INTO players (name) VALUES ('Ida');
-- INSERT INTO players (name) VALUES ('Ellen');
-- INSERT INTO players (name) VALUES ('Mikey');

-- INSERT INTO matches (player1, player2) VALUES (1, 2);
-- INSERT INTO matches (player1, player2) VALUES (3, 4);
-- INSERT INTO matches (player1, player2) VALUES (1, 3);
-- INSERT INTO matches (player1, player2) VALUES (2, 4);

-- INSERT INTO playsRecord (winner, loser) VALUES (1, 2);
-- INSERT INTO playsRecord (winner, loser) VALUES (3, 4);
-- INSERT INTO playsRecord (winner, loser) VALUES (3, 1);
-- INSERT INTO playsRecord (winner, loser) VALUES (4, 2);


-- Join player id from matches with player name
-- SELECT players.id as player_id, players.name from players, matches where players.id = matches.player1;

-- Count wins
-- Can I make a view for this?
-- SELECT count(winner) FROM playsRecord where winner = %s; % n
-- A better count wins
-- SELECT players.id as player_id, count(playsRecord.winner) as wins_count FROM players, playsRecord WHERE players.id = playsRecord.winner GROUP BY players.id ORDER BY wins_count DESC;

-- Count matches player1
-- SELECT players.id as player1_id, count(matches.player1) as matches_count FROM players, matches where players.id = matches.player1 GROUP BY players.id;
-- SELECT count(player1) FROM matches GROUP BY player1;


-- Count matches player2
-- SELECT players.id as player2_id, count(matches.player2) as matches_count FROM players, matches where players.id = matches.player2 GROUP BY players.id;

-- SELECT players.id as player_id, count(matches.player1) as matches_count, count(matches.player2) as matches_count_2 FROM players LEFT JOIN matches on players.id = matches.player1 or players.id = matches.player2 GROUP BY players.id;

-- SELECT player_name_id.player_id, player_name_id.name, wins_count.wins_count FROM player_name_id, wins_count, players, playsRecord WHERE player_name_id.player_id = wins_count.player_id GROUP BY player_name_id.player_id, player_name_id.name, wins_count.wins_count;


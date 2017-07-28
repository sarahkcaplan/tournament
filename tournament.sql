-- Table definitions for the tournament project.

DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;

\c tournament;

CREATE TABLE players (id serial PRIMARY KEY, name text UNIQUE NOT NULL, created timestamp DEFAULT current_timestamp);

CREATE TABLE matches (id serial PRIMARY KEY, winner integer NOT NULL, loser integer NOT NULL, FOREIGN KEY (winner) REFERENCES players (id), FOREIGN KEY (loser) REFERENCES players (id));

CREATE VIEW player_name_id AS SELECT players.id as player_id, players.name as name FROM players ORDER BY player_id;

CREATE VIEW wins_count AS SELECT players.id as player_id, count(matches.winner) as wins_count FROM players LEFT JOIN matches ON players.id = matches.winner GROUP BY players.id ORDER BY wins_count DESC;

CREATE VIEW matches_count AS SELECT players.id as player_id, count(matches.id) as matches_ct FROM players LEFT JOIN matches ON players.id = matches.winner OR players.id = matches.loser GROUP BY players.id ORDER BY player_id;

CREATE VIEW names_wins_count AS SELECT player_name_id.player_id as id, player_name_id.name as name, wins_count.wins_count as wins FROM player_name_id RIGHT JOIN wins_count on player_name_id.player_id = wins_count.player_id GROUP BY player_name_id.player_id, player_name_id.name, wins_count.wins_count;

CREATE VIEW player_standings1 AS SELECT names_wins_count.id as id, names_wins_count.name as name, names_wins_count.wins as wins, matches_count.matches_ct as matches FROM names_wins_count LEFT JOIN matches_count ON names_wins_count.id = matches_count.player_id ORDER BY wins DESC;


-- -- "Wins Count"
-- SELECT players.id as player_id, count(matches.winner) as wins_count FROM players LEFT JOIN matches ON players.id = matches.winner GROUP BY players.id ORDER BY wins_count DESC;

-- -- "Matches Count"
-- SELECT players.id as player_id, count(matches.id) as matches_ct FROM players LEFT JOIN matches ON players.id = matches.winner OR players.id = matches.loser GROUP BY players.id ORDER BY player_id;

-- -- "Player Standings"
-- CREATE VIEW names_matches_count AS SELECT player_name_id.player_id as id, player_name_id.name as name, matches_count.matches_ct as MAAATCHES FROM player_name_id RIGHT JOIN matches_count on player_name_id.player_id = matches_count.player_id GROUP BY player_name_id.player_id, player_name_id.name, matches_count.matches_ct;


-- SELECT player_name_id.player_id as id, player_name_id.name as name, wins_count.wins_count as wins FROM player_name_id RIGHT JOIN wins_count on player_name_id.player_id = wins_count.player_id GROUP BY player_name_id.player_id, player_name_id.name, wins_count.wins_count;

-- SELECT names_wins_count.id as id, names_wins_count.name as name, names_wins_count.wins as wins, matches_count.matches_ct as matches FROM names_wins_count LEFT JOIN matches_count ON names_wins_count.id = matches_count.player_id;

-- SELECT * FROM player_standings1;
-- INSERT INTO matches (winner, loser) VALUES (1, 2);

-- INSERT INTO matches (winner, loser) VALUES (2, 4);

-- SELECT players.id as player_id, count(matches.winner) as wins_count FROM players LEFT JOIN matches ON players.id = matches.winner GROUP BY players.id ORDER BY wins_count DESC;

-- SELECT players.id as player_id, count(matches.id) as matches_ct FROM players LEFT JOIN matches ON players.id = matches.winner OR players.id = matches.loser GROUP BY players.id ORDER BY player_id;

-- SELECT player_name_id.player_id as id, player_name_id.name as name, wins_count.wins_count as wins, matches_count.matches_ct as matches FROM player_name_id, wins_count, matches_count WHERE player_name_id.player_id = wins_count.player_id and player_name_id.player_id = matches_count.player_id ORDER BY wins_count DESC;

-- SELECT player_name_id.player_id as id, player_name_id.name as name, wins_count.player_id as wins, matches_count.player_id as matches FROM player_name_id, wins_count, matches_count GROUP BY player_name_id.player_id, player_name_id.name ORDER BY player_name_id.player_id;



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


-- Table: users
CREATE TABLE users (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    password VARCHAR(100),
    phone VARCHAR(15),
    birthdate DATE,
    age INT,
    genre VARCHAR(10),
    address TEXT
);

-- Table: leagues
CREATE TABLE leagues (
    id INT PRIMARY KEY,
    id_admin INT,
    name VARCHAR(100),
    type VARCHAR(50),
    description TEXT,
    start_date DATE,
    end_date DATE,
    genre VARCHAR(10),
    minimum_age INT,
    league_address TEXT,
    privacy VARCHAR(10),
    points_per_win INT,
    points_per_draw INT,
    FOREIGN KEY (id_admin) REFERENCES users(id)
);

-- Table: teams
CREATE TABLE teams (
    id INT PRIMARY KEY,
    captain_id INT,
    name VARCHAR(100),
    shield_url TEXT,
    description TEXT,
    FOREIGN KEY (captain_id) REFERENCES users(id)
);

-- Table: team_players
CREATE TABLE team_players (
    team_id INT,
    player_id INT AUTO_INCREMENT,
    status VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dni VARCHAR(20),
    phone VARCHAR(15),
    birthdate DATE,
    age INT,
    genre VARCHAR(10),
    profile_url TEXT,
    goal_count INT,
    mvp_count INT,
    PRIMARY KEY (team_id, player_id),
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

-- Table: matches
CREATE TABLE matches (
    id INT PRIMARY KEY,
    league_id INT,
    away_team_id INT,
    home_team_id INT,
    date DATE,
    away_goals INT,
    home_goals INT,
    round INT,
    mvp INT,
    FOREIGN KEY (league_id) REFERENCES leagues(id),
    FOREIGN KEY (away_team_id) REFERENCES teams(id),
    FOREIGN KEY (home_team_id) REFERENCES teams(id)
);

-- Table: player_in_match
CREATE TABLE player_in_match (
    match_id INT,
    team_id INT,
    player_id INT,
    status VARCHAR(50),
    goals INT,
    red_count INT,
    yellow_count INT,
    PRIMARY KEY (match_id, team_id, player_id),
    FOREIGN KEY (match_id) REFERENCES matches(id),
    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (player_id) REFERENCES team_players(player_id)
);

-- Table: team_leagues
CREATE TABLE team_leagues (
    id INT PRIMARY KEY,
    team_id INT,
    league_id INT,
    points INT,
    goal_for INT,
    goal_against INT,
    no_goal_count INT,
    played_matches INT,
    win_matches INT,
    lost_matches INT,
    draw_matches INT,
    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (league_id) REFERENCES leagues(id)
);

-- Table: player_league_stats
CREATE TABLE player_league_stats (
    team_id INT,
    league_id INT,
    player_id INT,
    goal_count INT,
    number INT,
    yellow_count INT,
    red_count INT,
    mvp_count INT,
    played_games INT,
    PRIMARY KEY (team_id, league_id, player_id),
    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (league_id) REFERENCES leagues(id),
    FOREIGN KEY (player_id) REFERENCES team_players(player_id)
);

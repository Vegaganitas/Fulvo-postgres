-- Cambiar nombres de las tablas
ALTER TABLE main.usuarios RENAME TO users;
ALTER TABLE main.equipos RENAME TO teams;
ALTER TABLE main.jugadores_equipos RENAME TO team_players;
ALTER TABLE main.ligas RENAME TO leagues;
ALTER TABLE main.equipos_ligas RENAME TO team_leagues;
ALTER TABLE main.partidos RENAME TO matches;

-- Cambiar nombres de las columnas en cada tabla
-- Tabla: users
ALTER TABLE main.users RENAME COLUMN nombre TO first_name;
ALTER TABLE main.users RENAME COLUMN apellido TO last_name;
ALTER TABLE main.users RENAME COLUMN contraseña TO password;

-- Tabla: teams
ALTER TABLE main.teams RENAME COLUMN nombre TO name;
ALTER TABLE main.teams RENAME COLUMN escudo_url TO shield_url;
ALTER TABLE main.teams RENAME COLUMN id_capitan TO captain_id;

-- Tabla: team_players
ALTER TABLE main.team_players RENAME COLUMN id_jugador TO player_id;
ALTER TABLE main.team_players RENAME COLUMN id_equipo TO team_id;
ALTER TABLE main.team_players RENAME COLUMN estado TO status;

-- Tabla: leagues
ALTER TABLE main.leagues RENAME COLUMN nombre TO name;
ALTER TABLE main.leagues RENAME COLUMN tipo TO type;
ALTER TABLE main.leagues RENAME COLUMN descripcion TO description;
ALTER TABLE main.leagues RENAME COLUMN fecha_inicio TO start_date;
ALTER TABLE main.leagues RENAME COLUMN fecha_fin TO end_date;

-- Tabla: team_leagues
ALTER TABLE main.team_leagues RENAME COLUMN id_equipo TO team_id;
ALTER TABLE main.team_leagues RENAME COLUMN id_liga TO league_id;
ALTER TABLE main.team_leagues RENAME COLUMN estado TO status;

-- Tabla: matches
ALTER TABLE main.matches RENAME COLUMN id_liga TO league_id;
ALTER TABLE main.matches RENAME COLUMN id_equipo_local TO home_team_id;
ALTER TABLE main.matches RENAME COLUMN id_equipo_visitante TO away_team_id;
ALTER TABLE main.matches RENAME COLUMN fecha TO date;
ALTER TABLE main.matches RENAME COLUMN resultado TO result;






ALTER TABLE main.users
ALTER COLUMN dni TYPE INT USING dni::INTEGER;

ALTER TABLE main.users
ALTER COLUMN phone TYPE BIGINT USING phone::BIGINT;

ALTER TABLE main.users
ADD COLUMN genre VARCHAR(20) COLLATE pg_catalog."default",
ADD COLUMN address VARCHAR(255) COLLATE pg_catalog."default";

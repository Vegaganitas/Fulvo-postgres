-- DROP TABLE IF EXISTS main.leagues;

CREATE TABLE IF NOT EXISTS main.leagues
(
    id integer NOT NULL DEFAULT nextval('main.ligas_id_seq'::regclass),
    name character varying(100) COLLATE pg_catalog."default",
    type character varying(20) COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    start_date date,
    end_date date,
    genre character varying(20) COLLATE pg_catalog."default",
    minimum_age integer,
    id_admin integer NOT NULL,
    league_address character varying(50) COLLATE pg_catalog."default",
    privacy character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT ligas_pkey PRIMARY KEY (id),
    CONSTRAINT fk_id_admin FOREIGN KEY (id_admin)
        REFERENCES main.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT leagues_minimum_age_check CHECK (minimum_age >= 0)
)

-- DROP TABLE IF EXISTS main.matches;

CREATE TABLE IF NOT EXISTS main.matches
(
    id integer NOT NULL DEFAULT nextval('main.partidos_id_seq'::regclass),
    league_id integer,
    home_team_id integer,
    away_team_id integer,
    date date,
    result character varying(20) COLLATE pg_catalog."default",
    round integer,
    mvp integer,
    CONSTRAINT partidos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_mvp FOREIGN KEY (mvp)
        REFERENCES main.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT partidos_id_equipo_local_fkey FOREIGN KEY (home_team_id)
        REFERENCES main.teams (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT partidos_id_equipo_visitante_fkey FOREIGN KEY (away_team_id)
        REFERENCES main.teams (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT partidos_id_liga_fkey FOREIGN KEY (league_id)
        REFERENCES main.leagues (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

-- DROP TABLE IF EXISTS main.team_leagues;

CREATE TABLE IF NOT EXISTS main.team_leagues
(
    id integer NOT NULL DEFAULT nextval('main.equipos_ligas_id_seq'::regclass),
    team_id integer,
    league_id integer,
    status character varying(20) COLLATE pg_catalog."default" DEFAULT 'pendiente'::character varying,
    CONSTRAINT equipos_ligas_pkey PRIMARY KEY (id),
    CONSTRAINT equipos_ligas_id_equipo_fkey FOREIGN KEY (team_id)
        REFERENCES main.teams (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT equipos_ligas_id_liga_fkey FOREIGN KEY (league_id)
        REFERENCES main.leagues (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)


-- DROP TABLE IF EXISTS main.team_players;

CREATE TABLE IF NOT EXISTS main.team_players
(
    id integer NOT NULL DEFAULT nextval('main.jugadores_equipos_id_seq'::regclass),
    player_id integer,
    team_id integer,
    status character varying(20) COLLATE pg_catalog."default" DEFAULT 'pendiente'::character varying,
    CONSTRAINT jugadores_equipos_pkey PRIMARY KEY (id),
    CONSTRAINT jugadores_equipos_id_equipo_fkey FOREIGN KEY (team_id)
        REFERENCES main.teams (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT jugadores_equipos_id_jugador_fkey FOREIGN KEY (player_id)
        REFERENCES main.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

-- DROP TABLE IF EXISTS main.teams;

CREATE TABLE IF NOT EXISTS main.teams
(
    id integer NOT NULL DEFAULT nextval('main.equipos_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default",
    shield_url character varying(255) COLLATE pg_catalog."default",
    captain_id integer,
    description character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT equipos_pkey PRIMARY KEY (id),
    CONSTRAINT equipos_id_capitan_fkey FOREIGN KEY (captain_id)
        REFERENCES main.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

-- DROP TABLE IF EXISTS main.users;

CREATE TABLE IF NOT EXISTS main.users
(
    id integer NOT NULL DEFAULT nextval('main.usuarios_id_seq'::regclass),
    first_name character varying(255) COLLATE pg_catalog."default",
    last_name character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    dni integer,
    phone bigint,
    birthdate date,
    age integer,
    genre character varying(20) COLLATE pg_catalog."default",
    address character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT usuarios_pkey PRIMARY KEY (id),
    CONSTRAINT usuarios_email_key UNIQUE (email)
)


-- Trigger: set_age

-- DROP TRIGGER IF EXISTS set_age ON main.users;

CREATE OR REPLACE TRIGGER set_age
    BEFORE INSERT OR UPDATE 
    ON main.users
    FOR EACH ROW
    EXECUTE FUNCTION main.update_age();



-- FUNCTION: main.update_age()

-- DROP FUNCTION IF EXISTS main.update_age();

CREATE OR REPLACE FUNCTION main.update_age()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  NEW.age := DATE_PART('year', AGE(NEW.birthdate));
  RETURN NEW;
END;
$BODY$;

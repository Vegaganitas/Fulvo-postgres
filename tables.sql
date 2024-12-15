CREATE TABLE main.usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    contraseña TEXT,
    rol VARCHAR(20)
);

CREATE TABLE main.equipos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    escudo_url TEXT,
    id_capitan INTEGER REFERENCES main.usuarios(id)
);

CREATE TABLE main.jugadores_equipos (
    id SERIAL PRIMARY KEY,
    id_jugador INTEGER REFERENCES main.usuarios(id),
    id_equipo INTEGER REFERENCES main.equipos(id),
    estado VARCHAR(20) DEFAULT 'pendiente'
);

CREATE TABLE main.ligas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(20),
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE
);
--Crear campo sede

CREATE TABLE main.equipos_ligas (
    id SERIAL PRIMARY KEY,
    id_equipo INTEGER REFERENCES main.equipos(id),
    id_liga INTEGER REFERENCES main.ligas(id),
    estado VARCHAR(20) DEFAULT 'pendiente'
);

CREATE TABLE main.partidos (
    id SERIAL PRIMARY KEY,
    id_liga INTEGER REFERENCES main.ligas(id),
    id_equipo_local INTEGER REFERENCES main.equipos(id),
    id_equipo_visitante INTEGER REFERENCES main.equipos(id),
    fecha DATE,
    resultado VARCHAR(20)
);--numero jornada

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    contraseña TEXT,
    rol VARCHAR(20)
);

CREATE TABLE equipos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    escudo_url TEXT,
    id_capitan INTEGER REFERENCES usuarios(id)
);

CREATE TABLE jugadores_equipos (
    id SERIAL PRIMARY KEY,
    id_jugador INTEGER REFERENCES usuarios(id),
    id_equipo INTEGER REFERENCES equipos(id),
    estado VARCHAR(20) DEFAULT 'pendiente'
);

CREATE TABLE ligas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(20),
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE
);
--Crear campo sede

CREATE TABLE equipos_ligas (
    id SERIAL PRIMARY KEY,
    id_equipo INTEGER REFERENCES equipos(id),
    id_liga INTEGER REFERENCES ligas(id),
    estado VARCHAR(20) DEFAULT 'pendiente'
);

CREATE TABLE partidos (
    id SERIAL PRIMARY KEY,
    id_liga INTEGER REFERENCES ligas(id),
    id_equipo_local INTEGER REFERENCES equipos(id),
    id_equipo_visitante INTEGER REFERENCES equipos(id),
    fecha DATE,
    resultado VARCHAR(20)
);--numero jornada

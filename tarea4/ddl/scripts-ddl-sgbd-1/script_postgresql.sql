RED SOCIAL ESTUDIANTIL PASCUALINA
SGBD: PostgreSQL

DROP TABLE IF EXISTS perfil$habilidad CASCADE;
DROP TABLE IF EXISTS miembro$grupo CASCADE;
DROP TABLE IF EXISTS seguidor CASCADE;
DROP TABLE IF EXISTS evento CASCADE;
DROP TABLE IF EXISTS publicacion CASCADE;
DROP TABLE IF EXISTS habilidad CASCADE;
DROP TABLE IF EXISTS grupo CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;

 USUARIO
CREATE TABLE usuario (
    id$usuario SERIAL PRIMARY KEY,
    nombre$completo VARCHAR(100) NOT NULL,
    correo$electronico VARCHAR(150) UNIQUE NOT NULL,
    rol$usuario VARCHAR(50) NOT NULL,
    configuracion$json JSONB -- Campo semiestructurado para Big Data / IoT
);

 GRUPO
CREATE TABLE grupo (
    id$grupo SERIAL PRIMARY KEY,
    nombre$grupo VARCHAR(100) NOT NULL,
    descripcion$grupo VARCHAR(300)
);

 HABILIDAD
CREATE TABLE habilidad (
    id$habilidad SERIAL PRIMARY KEY,
    nombre$habilidad VARCHAR(100) NOT NULL,
    categoria$habilidad VARCHAR(50) NOT NULL
);

 PUBLICACION
CREATE TABLE publicacion (
    id$publicacion SERIAL PRIMARY KEY,
    contenido$publicacion VARCHAR(500) NOT NULL,
    tipo$post VARCHAR(50) NOT NULL,
    id$usuario$autor INT NOT NULL,
    CONSTRAINT fk$publicacion$usuario 
        FOREIGN KEY (id$usuario$autor) 
        REFERENCES usuario(id$usuario) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

 EVENTO
CREATE TABLE evento (
    id$evento SERIAL PRIMARY KEY,
    titulo$evento VARCHAR(150) NOT NULL,
    fecha$evento DATE NOT NULL,
    descripcion$evento VARCHAR(300),
    id$usuario$organizador INT NOT NULL,
    CONSTRAINT fk$evento$usuario 
        FOREIGN KEY (id$usuario$organizador) 
        REFERENCES usuario(id$usuario) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

 SEGUIDOR
CREATE TABLE seguidor (
    id$seguidor INT NOT NULL,
    id$seguido INT NOT NULL,
    PRIMARY KEY (id$seguidor, id$seguido),
    CONSTRAINT fk$seguidor$usuario 
        FOREIGN KEY (id$seguidor) 
        REFERENCES usuario(id$usuario) 
        ON DELETE CASCADE,
    CONSTRAINT fk$seguido$usuario 
        FOREIGN KEY (id$seguido) 
        REFERENCES usuario(id$usuario) 
        ON DELETE CASCADE
);

 MIEMBRO_GRUPO
CREATE TABLE miembro$grupo (
    id$usuario INT NOT NULL,
    id$grupo INT NOT NULL,
    fecha$ingreso DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (id$usuario, id$grupo),
    CONSTRAINT fk$miembro$usuario 
        FOREIGN KEY (id$usuario) 
        REFERENCES usuario(id$usuario) 
        ON DELETE CASCADE,
    CONSTRAINT fk$miembro$grupo 
        FOREIGN KEY (id$grupo) 
        REFERENCES grupo(id$grupo) 
        ON DELETE CASCADE
);

 PERFIL_HABILIDAD
CREATE TABLE perfil$habilidad (
    id$usuario INT NOT NULL,
    id$habilidad INT NOT NULL,
    nivel$dominio VARCHAR(50),
    PRIMARY KEY (id$usuario, id$habilidad),
    CONSTRAINT fk$perfil$usuario 
        FOREIGN KEY (id$usuario) 
        REFERENCES usuario(id$usuario) 
        ON DELETE CASCADE,
    CONSTRAINT fk$perfil$habilidad 
        FOREIGN KEY (id$habilidad) 
        REFERENCES habilidad(id$habilidad) 
        ON DELETE CASCADE
);
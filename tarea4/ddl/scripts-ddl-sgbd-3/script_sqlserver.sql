 RED SOCIAL ESTUDIANTIL PASCUALINA

SGBD: SQL Server

CREATE TABLE usuario (
    id$usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre$completo VARCHAR(100) NOT NULL,
    correo$electronico VARCHAR(150) UNIQUE NOT NULL,
    rol$usuario VARCHAR(50) NOT NULL,
    configuracion$json VARCHAR(MAX) CHECK (ISJSON(configuracion$json) = 1) -- Valida formato JSON
);

CREATE TABLE grupo (
    id$grupo INT IDENTITY(1,1) PRIMARY KEY,
    nombre$grupo VARCHAR(100) NOT NULL,
    descripcion$grupo VARCHAR(300)
);

CREATE TABLE habilidad (
    id$habilidad INT IDENTITY(1,1) PRIMARY KEY,
    nombre$habilidad VARCHAR(100) NOT NULL,
    categoria$habilidad VARCHAR(50) NOT NULL
);

CREATE TABLE publicacion (
    id$publicacion INT IDENTITY(1,1) PRIMARY KEY,
    contenido$publicacion VARCHAR(500) NOT NULL,
    tipo$post VARCHAR(50) NOT NULL,
    id$usuario$autor INT NOT NULL,
    CONSTRAINT fk$publicacion$usuario 
        FOREIGN KEY (id$usuario$autor) 
        REFERENCES usuario(id$usuario) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE evento (
    id$evento INT IDENTITY(1,1) PRIMARY KEY,
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

CREATE TABLE miembro$grupo (
    id$usuario INT NOT NULL,
    id$grupo INT NOT NULL,
    fecha$ingreso DATE DEFAULT GETDATE(),
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
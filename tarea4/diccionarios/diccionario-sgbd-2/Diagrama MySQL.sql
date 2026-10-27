CREATE TABLE `USUARIO` (
  `id_usuario` INT PRIMARY KEY AUTO_INCREMENT COMMENT 'AUTO_INCREMENT en MySQL',
  `nombre` VARCHAR(100) NOT NULL,
  `correo` VARCHAR(150) UNIQUE NOT NULL,
  `rol` VARCHAR(50) NOT NULL,
  `configuracion_json` JSON COMMENT 'Tipo de dato JSON nativo de MySQL para telemetría IoT y configuraciones dinámicas.'
);

CREATE TABLE `GRUPO` (
  `id_grupo` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre_grupo` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(300)
);

CREATE TABLE `HABILIDAD` (
  `id_habilidad` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre_habilidad` VARCHAR(100) NOT NULL,
  `categoria` VARCHAR(50) NOT NULL
);

CREATE TABLE `PUBLICACION` (
  `id_publicacion` INT PRIMARY KEY AUTO_INCREMENT,
  `contenido` VARCHAR(500) NOT NULL,
  `tipo_post` VARCHAR(50) NOT NULL,
  `id_usuario_autor` INT NOT NULL
);

CREATE TABLE `EVENTO` (
  `id_evento` INT PRIMARY KEY AUTO_INCREMENT,
  `titulo` VARCHAR(150) NOT NULL,
  `fecha` DATE NOT NULL,
  `descripcion` VARCHAR(300),
  `id_usuario_organizador` INT NOT NULL
);

CREATE TABLE `SEGUIDOR` (
  `id_seguidor` INT,
  `id_seguido` INT,
  PRIMARY KEY (`id_seguidor`, `id_seguido`)
);

CREATE TABLE `MIEMBRO_GRUPO` (
  `id_usuario` INT,
  `id_grupo` INT,
  `fecha_ingreso` DATE NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_grupo`)
);

CREATE TABLE `PERFIL_HABILIDAD` (
  `id_usuario` INT,
  `id_habilidad` INT,
  `nivel_dominio` VARCHAR(50),
  PRIMARY KEY (`id_usuario`, `id_habilidad`)
);

ALTER TABLE `PUBLICACION` COMMENT = 'Relación 1:N con Usuario';

ALTER TABLE `EVENTO` COMMENT = 'Relación 1:N con Usuario';

ALTER TABLE `SEGUIDOR` COMMENT = 'PK Compuesta';

ALTER TABLE `PUBLICACION` ADD FOREIGN KEY (`id_usuario_autor`) REFERENCES `USUARIO` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `EVENTO` ADD FOREIGN KEY (`id_usuario_organizador`) REFERENCES `USUARIO` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `MIEMBRO_GRUPO` ADD FOREIGN KEY (`id_usuario`) REFERENCES `USUARIO` (`id_usuario`) ON DELETE CASCADE;

ALTER TABLE `MIEMBRO_GRUPO` ADD FOREIGN KEY (`id_grupo`) REFERENCES `GRUPO` (`id_grupo`) ON DELETE CASCADE;

ALTER TABLE `PERFIL_HABILIDAD` ADD FOREIGN KEY (`id_usuario`) REFERENCES `USUARIO` (`id_usuario`) ON DELETE CASCADE;

ALTER TABLE `PERFIL_HABILIDAD` ADD FOREIGN KEY (`id_habilidad`) REFERENCES `HABILIDAD` (`id_habilidad`) ON DELETE CASCADE;

ALTER TABLE `SEGUIDOR` ADD FOREIGN KEY (`id_seguidor`) REFERENCES `USUARIO` (`id_usuario`) ON DELETE CASCADE;

ALTER TABLE `SEGUIDOR` ADD FOREIGN KEY (`id_seguido`) REFERENCES `USUARIO` (`id_usuario`) ON DELETE CASCADE;

CREATE TABLE "USUARIO" (
  "id_usuario" SERIAL PRIMARY KEY,
  "nombre" "VARCHAR(100)" NOT NULL,
  "correo" "VARCHAR(150)" UNIQUE NOT NULL,
  "rol" "VARCHAR(50)" NOT NULL,
  "configuracion_json" JSONB
);

CREATE TABLE "GRUPO" (
  "id_grupo" SERIAL PRIMARY KEY,
  "nombre_grupo" "VARCHAR(100)" NOT NULL,
  "descripcion" "VARCHAR(300)"
);

CREATE TABLE "HABILIDAD" (
  "id_habilidad" SERIAL PRIMARY KEY,
  "nombre_habilidad" "VARCHAR(100)" NOT NULL,
  "categoria" "VARCHAR(50)" NOT NULL
);

CREATE TABLE "PUBLICACION" (
  "id_publicacion" SERIAL PRIMARY KEY,
  "contenido" "VARCHAR(500)" NOT NULL,
  "tipo_post" "VARCHAR(50)" NOT NULL,
  "id_usuario_autor" INT NOT NULL
);

CREATE TABLE "EVENTO" (
  "id_evento" SERIAL PRIMARY KEY,
  "titulo" "VARCHAR(150)" NOT NULL,
  "fecha" DATE NOT NULL,
  "descripcion" "VARCHAR(300)",
  "id_usuario_organizador" INT NOT NULL
);

CREATE TABLE "SEGUIDOR" (
  "id_seguidor" INT,
  "id_seguido" INT,
  PRIMARY KEY ("id_seguidor", "id_seguido")
);

CREATE TABLE "MIEMBRO_GRUPO" (
  "id_usuario" INT,
  "id_grupo" INT,
  "fecha_ingreso" DATE NOT NULL DEFAULT (current_date),
  PRIMARY KEY ("id_usuario", "id_grupo")
);

CREATE TABLE "PERFIL_HABILIDAD" (
  "id_usuario" INT,
  "id_habilidad" INT,
  "nivel_dominio" "VARCHAR(50)",
  PRIMARY KEY ("id_usuario", "id_habilidad")
);

COMMENT ON COLUMN "USUARIO"."id_usuario" IS 'Identificador único autoincremental';

COMMENT ON COLUMN "USUARIO"."correo" IS 'Correo institucional único';

COMMENT ON COLUMN "USUARIO"."rol" IS 'Estudiante, Mentor, etc.';

COMMENT ON COLUMN "USUARIO"."configuracion_json" IS 'Telemetría IoT, preferencias dinámicas y analítica Big Data. Formato binario optimizado.';

COMMENT ON TABLE "PUBLICACION" IS 'Relación 1:N con Usuario';

COMMENT ON COLUMN "PUBLICACION"."tipo_post" IS 'Pregunta, Meme, Noticia, Recurso';

COMMENT ON TABLE "EVENTO" IS 'Relación 1:N con Usuario';

COMMENT ON TABLE "SEGUIDOR" IS 'PK Compuesta y FKs';

COMMENT ON COLUMN "SEGUIDOR"."id_seguidor" IS 'Usuario que sigue';

COMMENT ON COLUMN "SEGUIDOR"."id_seguido" IS 'Usuario seguido (Mentor)';

COMMENT ON COLUMN "PERFIL_HABILIDAD"."nivel_dominio" IS 'Básico, Medio, Avanzado';

ALTER TABLE "PUBLICACION" ADD FOREIGN KEY ("id_usuario_autor") REFERENCES "USUARIO" ("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "EVENTO" ADD FOREIGN KEY ("id_usuario_organizador") REFERENCES "USUARIO" ("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "MIEMBRO_GRUPO" ADD FOREIGN KEY ("id_usuario") REFERENCES "USUARIO" ("id_usuario") ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "MIEMBRO_GRUPO" ADD FOREIGN KEY ("id_grupo") REFERENCES "GRUPO" ("id_grupo") ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "PERFIL_HABILIDAD" ADD FOREIGN KEY ("id_usuario") REFERENCES "USUARIO" ("id_usuario") ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "PERFIL_HABILIDAD" ADD FOREIGN KEY ("id_habilidad") REFERENCES "HABILIDAD" ("id_habilidad") ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "SEGUIDOR" ADD FOREIGN KEY ("id_seguidor") REFERENCES "USUARIO" ("id_usuario") ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "SEGUIDOR" ADD FOREIGN KEY ("id_seguido") REFERENCES "USUARIO" ("id_usuario") ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

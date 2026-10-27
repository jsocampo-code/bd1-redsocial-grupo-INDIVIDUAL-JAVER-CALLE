CREATE TABLE [USUARIO] (
  [id_usuario] INT PRIMARY KEY IDENTITY(1, 1),
  [nombre] VARCHAR(100) NOT NULL,
  [correo] VARCHAR(150) UNIQUE NOT NULL,
  [rol] VARCHAR(50) NOT NULL,
  [configuracion_json] VARCHAR(MAX)
)
GO

CREATE TABLE [GRUPO] (
  [id_grupo] INT PRIMARY KEY IDENTITY(1, 1),
  [nombre_grupo] VARCHAR(100) NOT NULL,
  [descripcion] VARCHAR(300)
)
GO

CREATE TABLE [HABILIDAD] (
  [id_habilidad] INT PRIMARY KEY IDENTITY(1, 1),
  [nombre_habilidad] VARCHAR(100) NOT NULL,
  [categoria] VARCHAR(50) NOT NULL
)
GO

CREATE TABLE [PUBLICACION] (
  [id_publicacion] INT PRIMARY KEY IDENTITY(1, 1),
  [contenido] VARCHAR(500) NOT NULL,
  [tipo_post] VARCHAR(50) NOT NULL,
  [id_usuario_autor] INT NOT NULL
)
GO

CREATE TABLE [EVENTO] (
  [id_evento] INT PRIMARY KEY IDENTITY(1, 1),
  [titulo] VARCHAR(150) NOT NULL,
  [fecha] DATE NOT NULL,
  [descripcion] VARCHAR(300),
  [id_usuario_organizador] INT NOT NULL
)
GO

CREATE TABLE [SEGUIDOR] (
  [id_seguidor] INT,
  [id_seguido] INT,
  PRIMARY KEY ([id_seguidor], [id_seguido])
)
GO

CREATE TABLE [MIEMBRO_GRUPO] (
  [id_usuario] INT,
  [id_grupo] INT,
  [fecha_ingreso] DATE NOT NULL,
  PRIMARY KEY ([id_usuario], [id_grupo])
)
GO

CREATE TABLE [PERFIL_HABILIDAD] (
  [id_usuario] INT,
  [id_habilidad] INT,
  [nivel_dominio] VARCHAR(50),
  PRIMARY KEY ([id_usuario], [id_habilidad])
)
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'IDENTITY(1,1) en SQL Server',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'USUARIO',
@level2type = N'Column', @level2name = 'id_usuario';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Campo de texto masivo con validación ISJSON() para configuraciones y telemetría IoT.',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'USUARIO',
@level2type = N'Column', @level2name = 'configuracion_json';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Relación 1:N con Usuario',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'PUBLICACION';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Relación 1:N con Usuario',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'EVENTO';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'PK Compuesta',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'SEGUIDOR';
GO

ALTER TABLE [PUBLICACION] ADD FOREIGN KEY ([id_usuario_autor]) REFERENCES [USUARIO] ([id_usuario]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [EVENTO] ADD FOREIGN KEY ([id_usuario_organizador]) REFERENCES [USUARIO] ([id_usuario]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [MIEMBRO_GRUPO] ADD FOREIGN KEY ([id_usuario]) REFERENCES [USUARIO] ([id_usuario]) ON DELETE CASCADE
GO

ALTER TABLE [MIEMBRO_GRUPO] ADD FOREIGN KEY ([id_grupo]) REFERENCES [GRUPO] ([id_grupo]) ON DELETE CASCADE
GO

ALTER TABLE [PERFIL_HABILIDAD] ADD FOREIGN KEY ([id_usuario]) REFERENCES [USUARIO] ([id_usuario]) ON DELETE CASCADE
GO

ALTER TABLE [PERFIL_HABILIDAD] ADD FOREIGN KEY ([id_habilidad]) REFERENCES [HABILIDAD] ([id_habilidad]) ON DELETE CASCADE
GO

ALTER TABLE [SEGUIDOR] ADD FOREIGN KEY ([id_seguidor]) REFERENCES [USUARIO] ([id_usuario]) ON DELETE CASCADE
GO

ALTER TABLE [SEGUIDOR] ADD FOREIGN KEY ([id_seguido]) REFERENCES [USUARIO] ([id_usuario]) ON DELETE CASCADE
GO

/*
 * CRIACAO DO BANCO DE DADOS 
 */
DROP DATABASE YouplaY
GO

CREATE DATABASE YouplaY
GO

USE YouplaY
GO

-----------------------------------------------------------------------------------------------------------------------------------------
/*
 * CRIAÇÃO DAS TABELAS 
 */

CREATE TABLE [Usuario] (
  [codigo] INT PRIMARY KEY,
  [usuario] VARCHAR(255) UNIQUE,
  [senha] VARCHAR(255)
)
GO

CREATE TABLE [Pessoa] (
  [codigo] INT PRIMARY KEY,
  [nome] VARCHAR(255),
  [sexo] VARCHAR(255),
  [data_nascimento] DATETIME,
  [idade] INT,
  [rg] VARCHAR(255),
  [cpf] VARCHAR(255),
  [email] VARCHAR(255),
  [foto] VARBINARY(max),
  [codigo_usuario] INT,
  [codigo_endereco] INT
)
GO

CREATE TABLE [Aluno] (
  [codigo] INT PRIMARY KEY,
  [codigo_pessoa] INT,
  [codigo_escolaridade] INT,
  [data_matricula] DATETIME,
  [codigo_status] INT,
  [codigo_vinculo] INT,
  [telefone] VARCHAR(20)
)
GO

CREATE TABLE [Escolaridade] (
  [codigo] int PRIMARY KEY,
  [descricao] VARCHAR(255)
)
GO

CREATE TABLE [Aluno_Status] (
  [codigo] int PRIMARY KEY,
  [descricao] VARCHAR(255)
)
GO

CREATE TABLE [Disciplina] (
  [codigo] int PRIMARY KEY,
  [descricao] VARCHAR(255),
  [codigo_data] INT,
  [total_vagas] INT,
  [vagas_disponiveis] INT
)
GO

CREATE TABLE [Data_Disciplina] (
  [codigo] INT PRIMARY KEY,
  [data] DATETIME
)
GO

CREATE TABLE [Tipo_Disciplina] (
  [codigo] INT,
  [descricao] VARCHAR(255)
)
GO

CREATE TABLE [Disciplina_Aluno] (
  [codigo_disciplina] INT,
  [codigo_aluno] INT
)
GO

CREATE TABLE [Professor_Status] (
  [codigo] int PRIMARY KEY,
  [descricao] VARCHAR(255)
)
GO

CREATE TABLE [Professor] (
  [codigo] int PRIMARY KEY,
  [codigo_pessoa] INT,
  [codigo_status] INT,
  [telefone] VARCHAR(20)
)
GO

CREATE TABLE [Disciplina_Professor] (
  [codigo_disciplina] INT,
  [codigo_professor] INT
)
GO

CREATE TABLE [Endereco] (
	[codigo] int PRIMARY KEY,
	[rua] VARCHAR(max),
	[numero] INT,
	[bairro] VARCHAR(max),
	[cidade] VARCHAR(max),
	[estado] CHAR(2),
	[cep] INT
)
GO

CREATE TABLE [Responsavel](
	[codigo] INT PRIMARY KEY,
	[codigo_aluno] INT,
	[codigo_endereco] INT,
	[codigo_vinculo] INT,
	[telefone] VARCHAR(20)
)
GO

CREATE TABLE [Vinculo](
	[codigo] INT PRIMARY KEY,
	[descricao] VARCHAR(max)
)
GO


-----------------------------------------------------------------------------------------------------------------------------------------
/*
 * CRIAÇÃO DA RELAÇÃO DE TABELAS 
 */

ALTER TABLE [Aluno] ADD FOREIGN KEY ([codigo_pessoa]) REFERENCES [Pessoa] ([codigo])
GO

ALTER TABLE [Aluno] ADD FOREIGN KEY ([codigo_escolaridade]) REFERENCES [Escolaridade] ([codigo])
GO

ALTER TABLE [Aluno] ADD FOREIGN KEY ([codigo_status]) REFERENCES [Aluno_Status] ([codigo])
GO

ALTER TABLE [Aluno] ADD FOREIGN KEY ([codigo_vinculo]) REFERENCES [Vinculo] ([codigo])
GO

ALTER TABLE [Pessoa] ADD FOREIGN KEY ([codigo_usuario]) REFERENCES [Usuario] ([codigo])
GO

ALTER TABLE [Pessoa] ADD FOREIGN KEY ([codigo_endereco]) REFERENCES [Endereco] ([codigo])
GO

ALTER TABLE [Pessoa] ADD FOREIGN KEY ([codigo_endereco]) REFERENCES [Endereco] ([codigo])
GO

ALTER TABLE [Tipo_Disciplina] ADD FOREIGN KEY ([codigo]) REFERENCES [Disciplina] ([codigo])
GO

ALTER TABLE [Disciplina_Aluno] ADD FOREIGN KEY ([codigo_disciplina]) REFERENCES [Disciplina] ([codigo])
GO

ALTER TABLE [Disciplina_Aluno] ADD FOREIGN KEY ([codigo_aluno]) REFERENCES [Aluno] ([codigo])
GO

ALTER TABLE [Professor] ADD FOREIGN KEY ([codigo_pessoa]) REFERENCES [Pessoa] ([codigo])
GO

ALTER TABLE [Professor] ADD FOREIGN KEY ([codigo_status]) REFERENCES [Professor_Status] ([codigo])
GO

ALTER TABLE [Disciplina_Professor] ADD FOREIGN KEY ([codigo_disciplina]) REFERENCES [Disciplina] ([codigo])
GO

ALTER TABLE [Disciplina_Professor] ADD FOREIGN KEY ([codigo_professor]) REFERENCES [Professor] ([codigo])
GO

ALTER TABLE [Responsavel] ADD FOREIGN KEY ([codigo_aluno]) REFERENCES [Aluno] ([codigo])
GO

ALTER TABLE [Responsavel] ADD FOREIGN KEY ([codigo_endereco]) REFERENCES [Endereco] ([codigo])
GO

ALTER TABLE [Responsavel] ADD FOREIGN KEY ([codigo_vinculo]) REFERENCES [Vinculo] ([codigo])
GO

ALTER TABLE [Disciplina] ADD FOREIGN KEY ([codigo_data]) REFERENCES [Data_Disciplina] ([codigo])
GO

-----------------------------------------------------------------------------------------------------------------------------------------
/*
 * INSERÇÃO DE DADOS 
 */


/* INSERIR NA TABELA ESCOLARIDADE */
INSERT INTO Escolaridade (codigo, descricao)
VALUES (1, 'Analfabeto')
GO

INSERT INTO Escolaridade (codigo, descricao)
VALUES (2, 'Fundamental Incompleto')
GO

INSERT INTO Escolaridade (codigo, descricao)
VALUES (3, 'Fundamental Completo')
GO

INSERT INTO Escolaridade (codigo, descricao)
VALUES (4, 'Médio Incompleto')
GO

INSERT INTO Escolaridade (codigo, descricao)
VALUES (5, 'Médio Completo')
GO

INSERT INTO Escolaridade (codigo, descricao)
VALUES (6, 'Superior Incompleto')
GO

INSERT INTO Escolaridade (codigo, descricao)
VALUES (7, 'Superior Completo')
GO

INSERT INTO Usuario (codigo, usuario, senha)
VALUES (0, 'admin', '1234')
GO

/*INSERIR NA TABELA VINCULO*/
INSERT INTO Vinculo (codigo, descricao)
VALUES (1, 'Pai')
GO

INSERT INTO Vinculo (codigo, descricao)
VALUES (2, 'Mãe')
GO

INSERT INTO Vinculo (codigo, descricao)
VALUES (3, 'Irmão(ã)')
GO

INSERT INTO Vinculo (codigo, descricao)
VALUES (4, 'Avô(ó)')
GO

INSERT INTO Vinculo (codigo, descricao)
VALUES (5, 'Tio(a)')
GO

INSERT INTO Vinculo (codigo, descricao)
VALUES (6, 'Outro Responsável Legal')
GO

-----------------------------------------------------------------------------------------------------------------------------------------
/*
 * CRIAÇÃO DE TRIGGERS
 */

-----------------------------------------------------------------------------------------------------------------------------------------
/*
 * CRIAÇÃO DE PROCEDURES
 */

create procedure spDelete(
	@codigo int,
	@tabela varchar(max)
)
as
begin
	declare @sql varchar(max);
	set @sql = 'delete ' + @tabela + ' where id = ' + cast(@codigo as varchar(max))
	exec(@sql)
END
GO

create procedure spConsulta
(
@id int ,
@tabela varchar(max)
)
as
begin
	declare @sql varchar(max);
	set @sql = 'select * from ' + @tabela + ' where id = ' + cast(@id as varchar(max))
	exec(@sql)
end
GO

create procedure spListagem
(
@tabela varchar(max),
@ordem varchar(max))
as
begin
	exec('select * from ' + @tabela + ' order by ' + @ordem)
end
GO

create procedure spProximoId
(@tabela varchar(max))
as
begin
	exec('select isnull(max(id) +1, 1) as MAIOR from ' + @tabela)
end
GO

CREATE PROCEDURE spObtemEscolaridade
AS
BEGIN
	SELECT dbo.Escolaridade.codigo, dbo.Escolaridade.descricao
	FROM dbo.Escolaridade
	ORDER BY dbo.Escolaridade.descricao
END
GO

CREATE PROCEDURE spObtemVinculoAluno
AS
BEGIN
	SELECT dbo.Vinculo.codigo, dbo.Vinculo.descricao
	FROM dbo.Vinculo
	ORDER BY dbo.Vinculo.codigo
END
GO

CREATE PROCEDURE spObtemLogin (@usuario VARCHAR(255), @senha VARCHAR(255))
AS
BEGIN
	SELECT codigo, usuario
	FROM dbo.Usuario
	WHERE usuario = @usuario
	AND senha = @senha
END
GO

-----------------------------------------------------------------------------------------------------------------------------------------
/*
 * CRIAÇÃO DE FUNCTIONS
 */
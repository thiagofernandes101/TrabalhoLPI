------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

/* criação do banco de dados */
drop database YouplaY
go

create database YouplaY
go

use YouplaY
go

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

/* criação das tabelas e suas relações */
create table [pessoa] (
  [codigo] int primary key identity(1,1),
  [codigo_usuario] int,
  [codigo_endereco] int,
  [nome] varchar(255),
  [genero] varchar(255),
  [data_nascimento] datetime,
  [idade] int,
  [rg] varchar(255),
  [cpf] varchar(255),
  [email] varchar(255),
  [foto] varbinary
)
go

create table [usuario] (
  [codigo] int primary key identity(1,1),
  [usuario] varchar(255),
  [senha] varchar(255)
)
go

create table [endereco] (
  [codigo] int primary key identity(1,1),
  [rua] varchar(255),
  [numero] int,
  [bairro] varchar(255),
  [cidade] varchar(255),
  [estado] varchar(255),
  [cep] int
)
go

create table [aluno] (
  [codigo] int primary key identity(1,1),
  [codigo_pessoa] int,
  [codigo_escolaridade] int,
  [codigo_responsavel] int,
  [codigo_status] int,
  [data_matricula] datetime,
  [telefone] varchar(255)
)
go

create table [aluno_status] (
  [codigo] int primary key identity(1,1),
  [descricao] varchar(255)
)
go

create table [escolaridade] (
  [codigo] int primary key identity(1,1),
  [descricao] varchar(255)
)
go

create table [responsavel] (
  [codigo] int primary key identity(1,1),
  [codigo_endereco] int,
  [codigo_vinculo] int,
  [nome] varchar(255),
  [rg] varchar(255),
  [cpf] varchar(255),
  [telefone] varchar(255)
)
go

create table [vinculo] (
  [codigo] int primary key identity(1,1),
  [descricao] varchar(255)
)
go

create table [disciplina] (
  [codigo] int primary key identity(1,1),
  [codigo_data] int,
  [descricao] varchar(255),
  [total_vagas] int,
  [vagas_disponiveis] int
)
go

create table [data_disciplina] (
  [codigo] int primary key identity(1,1),
  [data] datetime
)
go

create table [disciplina_aluno] (
  [codigo_disciplina] int,
  [codigo_aluno] int
)
go

create table [professor] (
  [codigo] int primary key identity(1,1),
  [codigo_pessoa] int,
  [codigo_status] int,
  [telefone] varchar(255)
)
go

create table [disciplina_professor] (
  [codigo_disciplina] int,
  [codigo_professor] int
)
go

create table [professor_status] (
  [codigo] int primary key identity(1,1),
  [descricao] varchar(255)
)
go

alter table [pessoa] add foreign key ([codigo_usuario]) references [usuario] ([codigo])
go

alter table [pessoa] add foreign key ([codigo_endereco]) references [endereco] ([codigo])
go

alter table [aluno] add foreign key ([codigo_pessoa]) references [pessoa] ([codigo])
go

alter table [aluno] add foreign key ([codigo_escolaridade]) references [escolaridade] ([codigo])
go

alter table [aluno] add foreign key ([codigo_responsavel]) references [responsavel] ([codigo])
go

alter table [aluno] add foreign key ([codigo_status]) references [aluno_status] ([codigo])
go

alter table [responsavel] add foreign key ([codigo_endereco]) references [endereco] ([codigo])
go

alter table [responsavel] add foreign key ([codigo_vinculo]) references [vinculo] ([codigo])
go

alter table [disciplina] add foreign key ([codigo_data]) references [data_disciplina] ([codigo])
go

alter table [disciplina_aluno] add foreign key ([codigo_disciplina]) references [disciplina] ([codigo])
go

alter table [disciplina_aluno] add foreign key ([codigo_aluno]) references [aluno] ([codigo])
go

alter table [professor] add foreign key ([codigo_pessoa]) references [pessoa] ([codigo])
go

alter table [professor] add foreign key ([codigo_status]) references [professor_status] ([codigo])
go

alter table [disciplina_professor] add foreign key ([codigo_disciplina]) references [disciplina] ([codigo])
go

alter table [disciplina_professor] add foreign key ([codigo_professor]) references [professor] ([codigo])
go

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

/* inserção de dados padrões */

-- inserir na tabela escolaridade
insert into escolaridade (descricao)
values ('Analfabeto')
go

insert into escolaridade (descricao)
values ('Fundamental Incompleto')
go

insert into escolaridade (descricao)
values ('Fundamental Completo')
go

insert into escolaridade (descricao)
values ('Médio Incompleto')
go

insert into escolaridade (descricao)
values ('Médio Completo')
go

insert into escolaridade (descricao)
values ('Superior Incompleto')
go

insert into escolaridade (descricao)
values ('Superior Completo')
go

-- inserir um usuário administrado na tabela de usuário
insert into usuario (usuario, senha)
values ('admin', '1234')
go

-- inserir na tabela vinculo
insert into vinculo (descricao)
values ('Pai')
go

insert into vinculo (descricao)
values ('Mãe')
go

insert into vinculo (descricao)
values ('Irmão(ã)')
go

insert into vinculo (descricao)
values ('Avô(ó)')
go

insert into vinculo (descricao)
values ('Tio(a)')
go

insert into vinculo (descricao)
values ('Outro responsável legal')
go

-- inserir na tabela aluno_status
insert into aluno_status (descricao)
values ('Matriculado')
go

insert into aluno_status (descricao)
values ('Trancado')
go

insert into aluno_status (descricao)
values ('Finalizado')
go

-- insert into professor_status
insert into professor_status (descricao)
values ('Ativo')
go

insert into professor_status (descricao)
values ('Inativo')
go

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

/* criacao de triggers */

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

/* criação de procedures */

-- procedure padrão para deletar dados
create procedure sp_delete
	(
		@codigo int,
		@tabela varchar(255)
	)
as
begin
	declare @sql varchar(max)
	set @sql = 'delete from ' + @tabela + ' where codigo = ' + cast(@codigo as varchar(max))
	exec(@sql)
end
go

-- procedure padrão para consulta de dados por id
create procedure sp_consulta
	(
		@codigo int,
		@tabela varchar(max)
	)
as
begin
	declare @sql varchar(max);
	set @sql = 'select * from ' + @tabela + ' where codgio = ' + cast(@codigo as varchar(max))
	exec(@sql)
end
go

-- procedure para listagem dos dados de alguma tabela
create procedure sp_listagem
	(
		@tabela varchar(max),
		@ordem varchar(max)
	)
as
begin
	exec('select * from ' + @tabela + ' order by ' + @ordem)
end
go

-- procedure para obter as escolaridades cadastradas
create procedure sp_obtem_escolaridade
as
begin
	select dbo.escolaridade.codigo, dbo.escolaridade.descricao
	from dbo.escolaridade
	order by dbo.escolaridade.descricao
end
go

-- procedure para obter o vínculo entre aluno e responsável
create procedure sp_obtem_vinculo_aluno
as
begin
	select dbo.vinculo.codigo, dbo.vinculo.descricao
	from dbo.vinculo
	order by dbo.vinculo.codigo
end
go

-- procedure para obter o usuário e fazer verificação de login
create procedure sp_obtem_login (@usuario varchar(255), @senha varchar(255))
as
begin
	select codigo, usuario
	from dbo.usuario
	where usuario = @usuario
	and senha = @senha
end
go

-- procedure para inserir o endereco
create procedure sp_inserir_endereco
	(
		@rua varchar(255),
		@numero int,
		@bairro varchar(255),
		@cidade varchar(255),
		@estado varchar(255),
		@cep int
	)
as
begin
	insert into endereco
	(
		rua,
		numero,
		bairro,
		cidade,
		estado,
		cep
	)
	values
	(
		@rua,
		@numero,
		@bairro,
		@cidade,
		@estado,
		@cep
	)
	return scope_identity()
end
go

-- procesure para inserir o usuário
create procedure sp_inserir_usuario
	(
		@email varchar(255)
	)
as
begin
	insert into usuario
	(
		usuario,
		senha
	)
	values
	(
		@email,
		'1234'
	)
	return scope_identity()
end
go

-- inserir na tabela pessoa
create procedure sp_inserir_pessoa
	(
		@codigo_endereco int,
		@codigo_usuario int,
		@nome varchar(255),
		@genero varchar(255),
		@data_nascimento datetime,
		@data_matricula datetime,
		@idade int,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@imagem varbinary
	)
as
begin
	insert into pessoa
	(
		codigo_endereco,
		codigo_usuario,
		nome,
		genero,
		data_nascimento,
		idade,
		rg,
		cpf,
		email,
		foto
	)
	values
	(
		@codigo_endereco,
		@codigo_usuario,
		@nome,
		@genero,
		@data_nascimento,
		@idade,
		@rg,
		@cpf,
		@email,
		@imagem
	)
	return scope_identity()
end
go

-- procedure para inserir na tabela responsável
create procedure sp_inserir_responsavel
	(
		@codigo_endereco int,
		@nome_responsavel varchar(255),
		@rg_responsavel varchar(255),
		@cpf_responsavel varchar(255),
		@telefone_responsavel varchar(255),
		@codigo_vinculo_responsavel int
	)
as
begin
	insert into responsavel
	(
		codigo_endereco,
		codigo_vinculo,
		nome,
		rg,
		cpf,
		telefone
	)
	values
	(
		@codigo_endereco,
		@codigo_vinculo_responsavel,
		@nome_responsavel,
		@rg_responsavel,
		@cpf_responsavel,
		@telefone_responsavel
	)
	return scope_identity()
end
go

-- procedure para inserir na tabela de aluno
create procedure sp_inserir_aluno
	(
		@nome varchar(255),
		@genero varchar(255),
		@data_nascimento datetime,
		@data_matricula datetime,
		@idade int,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@imagem varbinary,
		@rua varchar(255),
		@numero int,
		@bairro varchar(255),
		@cidade varchar(255),
		@estado varchar(255),
		@cep int,
		@telefone varchar(255),
		@codigo_escolaridade int,
		@nome_responsavel varchar(255),
		@rg_responsavel varchar(255),
		@cpf_responsavel varchar(255),
		@telefone_responsavel varchar(255),
		@codigo_vinculo_responsavel int
	)
as
	declare @error_code int
	select @error_code = @@error
begin try
	begin tran
		-- declaração de variáveis
		declare @existe_cpf int = 0
		declare @codigo_endereco int
		declare @codigo_pessoa int
		declare @codigo_responsavel int
		declare @codigo_usuario int

		set @existe_cpf = (select count(1) from pessoa where cpf = @cpf)

		if @existe_cpf > 0
		begin
			rollback tran
			raiserror('O aluno a ser cadastrado já existe', 16, 1)
		end
		else
		begin
			-- inserir o endereço informado para obter o código_endereco para a tabela pessoa
			exec @codigo_endereco = sp_inserir_endereco @rua, @numero, @bairro, @cidade, @estado, @cep

			-- inserir na tabela usuario o email e a senha padrão 1234
			exec @codigo_usuario = sp_inserir_usuario @email

			-- inserir a pessoa para obter o código correspondente
			exec @codigo_pessoa = sp_inserir_pessoa @codigo_endereco, @codigo_usuario, @nome, @genero, @data_nascimento, @data_matricula, @idade, @rg, @cpf, @email, @imagem

			-- inserir o responsavel para obter o código do responsável
			exec @codigo_responsavel = sp_inserir_responsavel @codigo_endereco, @nome_responsavel, @rg_responsavel, @cpf_responsavel, @telefone_responsavel, @codigo_vinculo_responsavel

			-- inserir na tabela aluno
			insert into aluno
			(
				codigo_pessoa,
				codigo_escolaridade,
				codigo_responsavel,
				codigo_status,
				data_matricula,
				telefone
			)
			values
			(
				@codigo_pessoa,
				@codigo_escolaridade,
				@codigo_responsavel,
				0,
				@data_matricula,
				@telefone
			)
			commit tran
		end

	select @error_code = 0
	return @error_code -- 0 se bem sucedido, diferente de 0 se falhar
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	return @error_code
end catch
go

-- inserir na tabela professor
create procedure sp_inserir_professor
	(
		@nome varchar(255),
		@genero varchar(255),
		@data_nascimento datetime,
		@data_matricula datetime,
		@idade int,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@imagem varbinary,
		@rua varchar(255),
		@numero int,
		@bairro varchar(255),
		@cidade varchar(255),
		@estado varchar(255),
		@cep int,
		@telefone varchar(255)
	)
as
	declare @error_code int
	select @error_code = @@error
begin try
	begin tran
		-- declaração de variáveis
		declare @existe_cpf int = 0
		declare @codigo_endereco int
		declare @codigo_pessoa int
		declare @codigo_usuario int

		set @existe_cpf = (select count(1) from pessoa where cpf = @cpf)

		if @existe_cpf > 0
		begin
			rollback tran
			raiserror('Professor a ser cadastrado já existe', 16, 1)
		end
		else
		begin
			-- inserir na tabela endereco
			exec @codigo_endereco = sp_inserir_endereco @rua, @numero, @bairro, @cidade, @estado, @cep

			-- inserir na tabela usuario
			exec @codigo_usuario = sp_inserir_usuario @email

			-- inserir na tabela pessoa
			exec @codigo_pessoa = sp_inserir_pessoa @codigo_endereco, @codigo_usuario, @nome, @genero, @data_nascimento, @data_matricula, @idade, @rg, @cpf, @email, @imagem

			-- inserir na tabela professor
			insert into professor
			(
				codigo_pessoa,
				codigo_status,
				telefone
			)
			values
			(
				@codigo_pessoa,
				0,
				@telefone
			)
		commit tran
		end

	select @error_code = 0
	return @error_code -- 0 se bem sucedido, diferente de 0 se falhar
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	return @error_code
end catch
go

-- procedure para inserir na tabela disciplina
create procedure sp_inserir_disciplina
	(
		@data datetime,
		@descricao varchar(255),
		@total_vagas int,
		@codigo_professor int
	)
as
	declare @error_code int
	select @error_code = @@error
begin try
	begin tran
		-- declaração de variáveis
	commit tran

	select @error_code = 0
	return @error_code -- 0 se bem sucedido, diferente de 0 se falhar
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	return @error_code
end catch
go
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

/* criação de functions */

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
create database NewYouPlay
go

use NewYouPlay
go

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* criação das tabelas e suas relações */
create table [pessoa] (
  [codigo] int primary key identity(1,1),
  [codigo_usuario] int,
  [codigo_endereco] int,
  [codigo_genero] int,
  [nome] varchar(255),
  [data_nascimento] datetime,
  [idade] int,
  [rg] varchar(255),
  [cpf] varchar(255),
  [email] varchar(255),
  [imagem] varbinary(max)
)
go

create table [genero] (
	[codigo] int primary key identity(1,1),
	[descricao] varchar(255)
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
  [cep] varchar(255)
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

alter table [pessoa] add foreign key ([codigo_genero]) references [genero] ([codigo])
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

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
values ('admin@admin.com', '1234')
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

-- inserir na tabela genero
insert into genero (descricao)
values ('Feminino')
go

insert into genero (descricao)
values ('Masculino')
go

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* criação de procedures */

-- obtem os usuários cadastrados a partir do usuario e senha informados
create or alter procedure sp_obtem_usuario
	(
		@usuario varchar(255),
		@senha varchar(255)
	)
as
begin
	select codigo, usuario
	from dbo.usuario
	where usuario = @usuario
	and senha = @senha
end
go

-- obtem status e genero
create or alter procedure sp_bag_listagem
	(
		@tabela varchar(255)
	)
as
begin
	declare @sql varchar(255)
	set @sql = 'select * from ' + @tabela
	exec(@sql)
end
go

-- procedure para inserir na tabela de endereço
create or alter procedure sp_insert_endereco
	(
		@rua varchar(255),
		@numero int,
		@bairro varchar(255),
		@cidade varchar(255),
		@estado varchar(255),
		@cep int
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
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
	commit
	return scope_identity()
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procesure para inserir o usuário
create or alter procedure sp_insert_usuario
	(
		@email varchar(255)
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
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
	commit
	return scope_identity()
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para inserir na tabela responsável
create or alter procedure sp_insert_responsavel
	(
		@codigo_endereco int,
		@nome_responsavel varchar(255),
		@rg_responsavel varchar(255),
		@cpf_responsavel varchar(255),
		@telefone_responsavel varchar(255),
		@codigo_vinculo_responsavel int
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
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
	commit
	return scope_identity()
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para inserir na tabela pessoa
create or alter procedure sp_insert_pessoa
	(
		@codigo_usuario int,
		@codigo_endereco int,
		@codigo_genero int,
		@nome varchar(255),
		@data_nascimento varchar(255),
		@idade int,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@imagem varbinary(max)
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		insert into pessoa
		(
			codigo_usuario,
			codigo_endereco,
			codigo_genero,
			nome,
			data_nascimento,
			idade,
			rg,
			cpf,
			email,
			imagem
		)
		values
		(
			@codigo_usuario,
			@codigo_endereco,
			@codigo_genero,
			@nome,
			@data_nascimento,
			@idade,
			@rg,
			@cpf,
			@email,
			@imagem
		)
	commit
	return scope_identity()
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- incluir dados de aluno
create or alter procedure sp_insert_aluno
	(
		@codigo int,
		@nome varchar(255),
		@genero int,
		@data_nascimento datetime,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@codigo_status int,
		@rua varchar(255),
		@numero int,
		@bairro varchar(255),
		@cidade varchar(255),
		@estado varchar(255),
		@cep varchar(255),
		@telefone varchar(255),
		@codigo_escolaridade int,
		@nome_responsavel varchar(255) = null,
		@rg_responsavel varchar(255) = null,
		@cpf_responsavel varchar(255) = null,
		@telefone_responsavel varchar(255) = null,
		@codigo_vinculo_responsavel int = null,
		@imagem varbinary(max) = null
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		-- declaração de variáveis
		declare @existe_cpf int
		declare @codigo_endereco int
		declare @codigo_pessoa int
		declare @codigo_responsavel int
		declare @codigo_usuario int
		declare @idade int

		set @existe_cpf = (select count(1) from pessoa where cpf = @cpf)

		if @existe_cpf > 0
			begin
				raiserror('CPF já cadastrado', 16, 1)
			end
		else
			begin
				-- obter o valor da idade
				set @idade = (select dbo.calcular_idade(@data_nascimento, getdate()) as idade)

				-- inserir o endereço informado para obter o código_endereco para a tabela pessoa
				exec @codigo_endereco = sp_insert_endereco @rua, @numero, @bairro, @cidade, @estado, @cep

				-- inserir na tabela usuario o email e a senha padrão 1234
				exec @codigo_usuario = sp_insert_usuario @email

				-- inserir a pessoa para obter o código correspondente
				exec @codigo_pessoa = sp_insert_pessoa @codigo_usuario, @codigo_endereco, @genero, @nome, @data_nascimento, @idade, @rg, @cpf, @email, @imagem

				-- inserir o responsavel para obter o código do responsável
				exec @codigo_responsavel = sp_insert_responsavel @codigo_endereco, @nome_responsavel, @rg_responsavel, @cpf_responsavel, @telefone_responsavel, @codigo_vinculo_responsavel

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
					@codigo_status,
					getdate(),
					@telefone
				)
			end
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para listar os alunos cadastrados
create or alter procedure sp_listagem_aluno
as
begin
	select aluno.codigo,
		pessoa.nome,
		aluno.data_matricula,
		disciplina_aluno.descricao as descricao_disciplina,
		pessoa.codigo_genero,
		pessoa.data_nascimento,
		aluno.data_matricula,
		pessoa.idade,
		pessoa.rg,
		pessoa.cpf,
		pessoa.email,
		aluno.codigo_status,
		aluno_status.descricao as descricao_status,
		endereco.rua,
		endereco.numero,
		endereco.bairro,
		endereco.cidade,
		endereco.estado,
		endereco.cep,
		aluno.telefone,
		aluno.codigo_escolaridade,
		escolaridade.descricao as descricao_escolaridade,
		responsavel.nome as nome_responsavel,
		responsavel.rg as rg_responsavel,
		responsavel.cpf as cpf_responsavel,
		responsavel.telefone as telefone_responsavel,
		aluno.codigo_responsavel as codigo_vinculo_responsavel,
		pessoa.imagem
	from aluno
	inner join pessoa
		on pessoa.codigo = aluno.codigo_pessoa
	inner join aluno_status
		on aluno_status.codigo = aluno.codigo_status
	inner join escolaridade
		on escolaridade.codigo = aluno.codigo_escolaridade
	inner join endereco
		on endereco.codigo = pessoa.codigo_endereco
	inner join responsavel
		on responsavel.codigo = aluno.codigo_responsavel
	left join (select disciplina_aluno.codigo_aluno, disciplina.descricao 
		from disciplina_aluno
		inner join disciplina
			on disciplina.codigo = disciplina_aluno.codigo_disciplina
		) disciplina_aluno
		on disciplina_aluno.codigo_aluno = aluno.codigo
end
go

-- procedure para consultar os alunos cadastrados
create or alter procedure sp_consulta_aluno
	(
		@codigo int
	)
as
begin
	select aluno.codigo,
		pessoa.nome,
		aluno.data_matricula,
		disciplina_aluno.descricao as descricao_disciplina,
		pessoa.codigo_genero,
		pessoa.data_nascimento,
		aluno.data_matricula,
		pessoa.idade,
		pessoa.rg,
		pessoa.cpf,
		pessoa.email,
		aluno.codigo_status,
		aluno_status.descricao as descricao_status,
		endereco.rua,
		endereco.numero,
		endereco.bairro,
		endereco.cidade,
		endereco.estado,
		endereco.cep,
		aluno.telefone,
		aluno.codigo_escolaridade,
		escolaridade.descricao as descricao_escolaridade,
		responsavel.nome as nome_responsavel,
		responsavel.rg as rg_responsavel,
		responsavel.cpf as cpf_responsavel,
		responsavel.telefone as telefone_responsavel,
		aluno.codigo_responsavel as codigo_vinculo_responsavel,
		pessoa.imagem
	from aluno
	inner join pessoa
		on pessoa.codigo = aluno.codigo_pessoa
	inner join aluno_status
		on aluno_status.codigo = aluno.codigo_status
	inner join escolaridade
		on escolaridade.codigo = aluno.codigo_escolaridade
	inner join endereco
		on endereco.codigo = pessoa.codigo_endereco
	inner join responsavel
		on responsavel.codigo = aluno.codigo_responsavel
	left join (select disciplina_aluno.codigo_aluno, disciplina.descricao 
		from disciplina_aluno
		inner join disciplina
			on disciplina.codigo = disciplina_aluno.codigo_disciplina
		) disciplina_aluno
		on disciplina_aluno.codigo_aluno = aluno.codigo
	where aluno.codigo = @codigo
end
go

-- procedure para atualizar o endereço cadastrado
create or alter procedure sp_update_endereco
	(
		@codigo_endereco int,
		@rua varchar(255),
		@numero int,
		@bairro varchar(255),
		@cidade varchar(255),
		@estado varchar(255),
		@cep int
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		update endereco
		set rua = @rua,
			numero = @numero,
			bairro = @bairro,
			cidade = @cidade,
			estado = @estado,
			cep = @cep
		where codigo = @codigo_endereco
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para atualizar o usuário cadastrado
create or alter procedure sp_update_usuario
	(
		@codigo_usuario int,
		@email varchar(255)
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		update usuario
		set usuario = @email
		where codigo = @codigo_usuario
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para atualizar os dados da pessoa cadastrada
create or alter procedure sp_update_pessoa
	(
		@codigo_pessoa int,
		@codigo_genero int,
		@nome varchar(255),
		@data_nascimento datetime,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@imagem varbinary(max)
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		-- declaração de variáveis
		declare @codigo_usuario_old int = (select codigo_usuario from pessoa where codigo = @codigo_pessoa)
		declare @idade int = (select dbo.calcular_idade(@data_nascimento, getdate()) as idade)

		-- atualizar informações da tabela pessoa
		update pessoa
		set codigo_genero = @codigo_genero,
			nome = @nome,
			data_nascimento = @data_nascimento,
			rg = @rg,
			cpf = @cpf,
			email = @email,
			imagem = @imagem
		where codigo = @codigo_pessoa

		-- atualizar informações da tabela usuário
		exec sp_update_usuario @codigo_usuario_old, @email
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para atualizar os dados do responsável cadastrado
create or alter procedure sp_update_responsavel
	(
		@codigo_responsavel int,
		@codigo_vinculo_responsavel int,
		@nome_responsavel varchar(255),
		@rg_responsavel varchar(255),
		@cpf_responsavel varchar(255),
		@telefone_responsavel varchar(255)
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		update responsavel
		set nome = @nome_responsavel,
			rg = @rg_responsavel,
			cpf = @cpf_responsavel,
			telefone = @telefone_responsavel,
			codigo_vinculo = @codigo_vinculo_responsavel
		where codigo = @codigo_responsavel
	commit
	return scope_identity()
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para alterar as informações de um aluno já cadastrado
create or alter procedure sp_update_aluno
	(
		@codigo int,
		@nome varchar(255),
		@genero int,
		@data_nascimento datetime,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@codigo_status int,
		@rua varchar(255),
		@numero int,
		@bairro varchar(255),
		@cidade varchar(255),
		@estado varchar(255),
		@cep varchar(255),
		@telefone varchar(255),
		@codigo_escolaridade int,
		@nome_responsavel varchar(255) = null,
		@rg_responsavel varchar(255) = null,
		@cpf_responsavel varchar(255) = null,
		@telefone_responsavel varchar(255) = null,
		@codigo_vinculo_responsavel int = null,
		@imagem varbinary(max) = null
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		-- declaração de variáveis
		declare @codigo_pessoa int = (select codigo_pessoa from aluno where codigo = @codigo)
		declare @codigo_responsavel int = (select codigo_responsavel from aluno where codigo = @codigo)
		declare @codigo_endereco int = (select codigo_endereco from pessoa where codigo = @codigo_pessoa)

		-- atualizar os registros na tabela aluno
		update aluno
		set codigo_escolaridade = @codigo_escolaridade,
			codigo_status = @codigo_status,
			telefone = @telefone
		where codigo = @codigo

		-- atualizar os registros na tabela pessoa
		exec sp_update_pessoa @codigo_pessoa, @genero, @nome, @data_nascimento, @rg, @cpf, @email, @imagem

		-- atualizar os registros na tabela endereço
		exec sp_update_endereco @codigo_endereco, @rua, @numero, @bairro, @cidade, @estado, @cep

		-- atualizar os registros na tabela responsável
		exec sp_update_responsavel @codigo_responsavel, @codigo_vinculo_responsavel, @nome_responsavel, @rg_responsavel, @cpf_responsavel, @telefone_responsavel
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para inserir dados na tabela professor
create or alter procedure sp_insert_professor
	(
		@codigo int,
		@nome varchar(255),
		@genero int,
		@data_nascimento datetime,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@codigo_status int,
		@rua varchar(255),
		@numero int,
		@bairro varchar(255),
		@cidade varchar(255),
		@estado varchar(255),
		@cep varchar(255),
		@telefone varchar(255),
		@imagem varbinary(max) = null
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		declare @existe_cpf int
		declare @codigo_endereco int
		declare @codigo_pessoa int
		declare @codigo_usuario int
		declare @idade int

		set @existe_cpf = (select count(1) from pessoa where cpf = @cpf)

		if @existe_cpf > 0
			begin
				raiserror('CPF já cadastrado', 16, 1)
			end
		else
			begin
				-- obter o valor da idade
				set @idade = (select dbo.calcular_idade(@data_nascimento, getdate()) as idade)

				-- inserir o endereço informado para obter o código_endereco para a tabela pessoa
				exec @codigo_endereco = sp_insert_endereco @rua, @numero, @bairro, @cidade, @estado, @cep

				-- inserir na tabela usuario o email e a senha padrão 1234
				exec @codigo_usuario = sp_insert_usuario @email

				-- inserir a pessoa para obter o código correspondente
				exec @codigo_pessoa = sp_insert_pessoa @codigo_usuario, @codigo_endereco, @genero, @nome, @data_nascimento, @idade, @rg, @cpf, @email, @imagem

				-- inserir na tabela aluno
				insert into professor
				(
					codigo_pessoa,
					codigo_status,
					telefone
				)
				values
				(
					@codigo_pessoa,
					@codigo_status,
					@telefone
				)
			end
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para listar os professores cadastrados
create or alter procedure sp_listagem_professor
as
begin
	select professor.codigo,
		pessoa.nome,
		disciplina_professor.descricao as descricao_disciplina,
		pessoa.codigo_genero,
		pessoa.data_nascimento,
		pessoa.idade,
		pessoa.rg,
		pessoa.cpf,
		pessoa.email,
		professor.codigo_status,
		professor_status.descricao as descricao_status,
		endereco.rua,
		endereco.numero,
		endereco.bairro,
		endereco.cidade,
		endereco.estado,
		endereco.cep,
		professor.telefone,
		pessoa.imagem
	from professor
	inner join pessoa
		on pessoa.codigo = professor.codigo_pessoa
	inner join professor_status
		on professor_status.codigo = professor.codigo
	inner join endereco
		on endereco.codigo = pessoa.codigo_endereco
	left join (select disciplina_professor.codigo_professor, disciplina.descricao
		from disciplina_professor
		inner join disciplina
			on disciplina.codigo = disciplina_professor.codigo_disciplina
		) disciplina_professor
		on disciplina_professor.codigo_professor = professor.codigo
end
go

-- procedure para consultar os professores cadastrados
create or alter procedure sp_consulta_professor
	(
		@codigo int
	)
as
begin
	select professor.codigo,
		pessoa.nome,
		disciplina_professor.descricao as descricao_disciplina,
		pessoa.codigo_genero,
		pessoa.data_nascimento,
		pessoa.idade,
		pessoa.rg,
		pessoa.cpf,
		pessoa.email,
		professor.codigo_status,
		professor_status.descricao as descricao_status,
		endereco.rua,
		endereco.numero,
		endereco.bairro,
		endereco.cidade,
		endereco.estado,
		endereco.cep,
		professor.telefone,
		pessoa.imagem
	from professor
	inner join pessoa
		on pessoa.codigo = professor.codigo_pessoa
	inner join professor_status
		on professor_status.codigo = professor.codigo
	inner join endereco
		on endereco.codigo = pessoa.codigo_endereco
	left join (select disciplina_professor.codigo_professor, disciplina.descricao
		from disciplina_professor
		inner join disciplina
			on disciplina.codigo = disciplina_professor.codigo_disciplina
		) disciplina_professor
		on disciplina_professor.codigo_professor = professor.codigo
	where professor.codigo = @codigo
end
go

-- procedure para alterar as informações de um professor já cadastrado
create or alter procedure sp_update_professor
	(
		@codigo int,
		@nome varchar(255),
		@genero int,
		@data_nascimento datetime,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@codigo_status int,
		@rua varchar(255),
		@numero int,
		@bairro varchar(255),
		@cidade varchar(255),
		@estado varchar(255),
		@cep varchar(255),
		@telefone varchar(255),
		@imagem varbinary(max) = null
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		-- declaração de variáveis
		declare @codigo_pessoa int = (select codigo_pessoa from professor where codigo = @codigo)
		declare @codigo_endereco int = (select codigo_endereco from pessoa where codigo = @codigo_pessoa)

		-- atualizar os registros na tabela aluno
		update professor
		set codigo_status = @codigo_status,
			telefone = @telefone
		where codigo = @codigo

		-- atualizar os registros na tabela pessoa
		exec sp_update_pessoa @codigo_pessoa, @genero, @nome, @data_nascimento, @rg, @cpf, @email, @imagem

		-- atualizar os registros na tabela endereço
		exec sp_update_endereco @codigo_endereco, @rua, @numero, @bairro, @cidade, @estado, @cep
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para inserir na tabela disciplina
create or alter procedure sp_insert_disciplina
	(
		@codigo int,
		@data datetime,
		@descricao varchar(255),
		@total_vagas int
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		-- declaração de variáveis
		declare @codigo_data int

		-- inserir data na tebela data_disciplina
		insert into data_disciplina
		(
			data
		)
		values
		(
			@data
		)
		set @codigo_data = scope_identity()

		insert into disciplina
		(
			codigo_data,
			descricao,
			total_vagas,
			vagas_disponiveis
		)
		values
		(
			@codigo_data,
			@descricao,
			@total_vagas,
			@total_vagas
		)
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

-- procedure para listagem das disciplinas cadastradas
create or alter procedure sp_listagem_disciplina
as
begin
	select disciplina.codigo,
		disciplina.descricao,
		disciplina.total_vagas,
		disciplina.vagas_disponiveis,
		data_disciplina.data
	from disciplina
	inner join data_disciplina
		on data_disciplina.codigo = disciplina.codigo_data
end
go

-- procedure para consulta das disciplinas cadastradas
create or alter procedure sp_consulta_disciplina
	(
		@codigo int
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin
	select disciplina.codigo,
		disciplina.descricao,
		disciplina.total_vagas,
		disciplina.vagas_disponiveis,
		data_disciplina.data
	from disciplina
	inner join data_disciplina
		on data_disciplina.codigo = disciplina.codigo_data
	where disciplina.codigo = @codigo
end
go

create or alter procedure sp_update_disciplina
	(
		@codigo int,
		@data datetime,
		@descricao varchar(255),
		@total_vagas int
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		-- declaração das variáveis utilizadas
		declare @codigo_data int = (select disciplina.codigo_data from disciplina where codigo = @codigo)

		-- atualizar a tabela disciplina
		update disciplina
		set descricao = @descricao,
			total_vagas = @total_vagas
		where codigo = @codigo

		-- atualizar a tabela data
		update data_disciplina
		set data = @data
		where @codigo = @codigo_data
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

--procedure para delete um registro de aluno
create or alter procedure sp_delete
	(
		@tabela varchar(255),
		@codigo int
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		declare @sql varchar(255) = 'delete from ' + @tabela + ' where codigo = ' + cast(@codigo as varchar(max))
		exec(@sql)
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	raiserror(@error, 16, 1)
end catch
go

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* criação de funções */

-- função para o calculo da idade de uma pessoa
create or alter function calcular_idade
	(
		@nascimento date,
        @data_base  date
	)
returns int
as
begin
  declare @idade      int;
  declare @dia_inicio int;
  declare @dia_fim    int;

  set @data_base = isnull(@data_base, getdate()); -- caso seja nula considera a data atual
  set @idade = datediff(year, @nascimento, @data_base);

  -- deve ser feito dessa forma por conta do ano bissexto
  -- por exemplo: dia 16/06 ficará 616 e 14/12 ficará 1214
  set @dia_inicio = (month(@nascimento) * 100) + day(@nascimento);
  set @dia_fim = (month(@data_base) * 100) + day(@data_base);

  -- se ainda não passou no ano base
  if @dia_fim < @dia_inicio
  begin
    set @idade = @idade - 1;
  end;

  return @idade;
end;
go

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* criação de triggers */

-- trigger a ser executada após o registro de aluno ser excluído
create or alter trigger tgr_aluno
on aluno
after delete
as
begin
	-- variáveis que serão utilizadas pelo cursor
	declare @codigo_pessoa int
	declare @codigo_responsavel int

	-- declaração do cursor
	declare cursor_aluno cursor for
		select codigo_pessoa, codigo_responsavel from deleted

	-- abertura do cursor
	open cursor_aluno

	-- vai para o primeiro registro e preenche as variáveis correspondentes
	fetch next from cursor_aluno
	into @codigo_pessoa, @codigo_responsavel

	-- enquanto houver registros faça
	while @@fetch_status = 0
		begin
			-- deletar os registros da tabela pessoa
			delete from pessoa
			where codigo = @codigo_pessoa

			-- deletar os registros da tabela responsável
			delete from responsavel
			where codigo = @codigo_responsavel

			-- vai para o próximo registro e preenche as variáveis correspondentes
			fetch next from cursor_aluno
			into @codigo_pessoa, @codigo_responsavel
		end

	-- fecha o cursor
	close cursor_aluno

	-- desaloca o cursor da memória
	deallocate cursor_aluno
end
go

-- trigger a ser executada após o registro de pessoa ser excluído
create or alter trigger tgr_pessoa
on pessoa
after delete
as
begin
	-- variáveis que serão executadas pelo cursor
	declare @codigo_endereco int
	declare @codigo_usuario int

	-- declaração do cursor
	declare cursor_pessoa cursor for
		select codigo_endereco, codigo_usuario from deleted

	-- abertura do cursor
	open cursor_pessoa

	-- vai para o primeiro registro e preenche as variáveis correspondentes
	fetch next from cursor_pessoa
	into @codigo_endereco, @codigo_usuario

	-- enquanto houver registros faça
	while @@fetch_status = 0
		begin
			-- deletar os registros da tabela endereco
			delete from endereco
			where codigo = @codigo_endereco

			-- deletar os registros da tabela usuário
			delete from usuario
			where codigo = @codigo_usuario

			-- vai para o próximo registro e preenche as variáveis correspondentes
			fetch next from cursor_pessoa
			into @codigo_endereco, @codigo_usuario
		end
	
	-- fecha o cursor
	close cursor_pessoa

	-- desaloca o cursor da memória
	deallocate cursor_pessoa
end
go

-- trigger a ser executada após o registro de professor ser excluído
create or alter trigger tgr_professor
on professor
after delete
as
begin
	-- variáveis que serão utilizadas pelo cursor
	declare @codigo_pessoa int

	-- declaração do cursor
	declare cursor_professor cursor for
		select codigo_pessoa from deleted

	-- abertura do cursor
	open cursor_professor

	-- vai para o primeiro registro e preenche as variáveis correspondentes
	fetch next from cursor_professor
	into @codigo_pessoa

	-- enquanto houver registros faça
	while @@fetch_status = 0
		begin
			-- deletar os registros da tabela pessoa
			delete from pessoa
			where codigo = @codigo_pessoa

			-- vai para o próximo registro e preenche as variáveis correspondentes
			fetch next from cursor_professor
			into @codigo_pessoa
		end

	-- fecha o cursor
	close cursor_professor

	-- desaloca o cursor da memória
	deallocate cursor_professor
end
go

-- trigger a ser executada ápós o registro da disciplina ser excluído
create or alter trigger tgr_disciplina
on disciplina
after delete
as
begin
	-- variáveis que serão utilizadas pelo cursor
	declare @codigo_data int

	-- declaração do cursor
	declare cursor_disciplina cursor for
		select codigo_data from deleted

	-- abertura do cursor
	open cursor_disciplina

	-- vai para o primeiro registro e preenche as variáveis correspondentes
	fetch next from cursor_disciplina
	into @codigo_data

	-- enquanto houver registros faça
	while @@fetch_status = 0
		begin
			-- deletar os registro da tabela data_disciplina
			delete from data_disciplina
			where codigo = @codigo_data

			-- vai para o próximo registro e preenche as variáveis correspondentes
			fetch next from cursor_disciplina
			into @codigo_data
		end

	-- fecha o cursor
	close cursor_disciplina

	-- desaloca o cursor da memória
	deallocate cursor_disciplina
end
go
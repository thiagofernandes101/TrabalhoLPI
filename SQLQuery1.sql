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
  [foto] varchar(255)
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
create procedure sp_delete_aluno
	(
		@codigo int
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
		declare @codigo_usuario int = (select codigo_usuario from pessoa where codigo = @codigo_pessoa)
		declare @codigo_endereco int = (select codigo_endereco from pessoa where codigo = @codigo_pessoa)
		
		delete from aluno where codigo = @codigo
		delete from pessoa where codigo = @codigo_pessoa
		delete from responsavel where codigo = @codigo_responsavel
		delete from endereco where codigo = @codigo_endereco	
		delete from usuario where codigo = @codigo_usuario	
	commit
end try
begin catch
	set @error = ERROR_MESSAGE()
	rollback
end catch
go

-- procedure para deletar da tabela professor
create procedure sp_delete_professor
	(
		@codigo int
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		-- declaração de variáveis
		declare @codigo_pessoa int = (select codigo_pessoa from professor where codigo = @codigo)
		declare @codigo_usuario int = (select codigo_usuario from pessoa where codigo = @codigo_pessoa)
		declare @codigo_endereco int = (select codigo_endereco from pessoa where codigo = @codigo_pessoa)

		delete from professor where codigo = @codigo
		delete from pessoa where codigo = @codigo_pessoa
		delete from endereco where codigo = @codigo_endereco	
		delete from usuario where codigo = @codigo_usuario
	commit
end try
begin catch
	set @error = ERROR_MESSAGE()
	rollback
end catch
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

-- procedure para obter o status do aluno ou do professor
create procedure sp_obtem_status (@tabela as varchar(255))
as
begin
	declare @sql varchar(255) = 'select codigo, descricao from ' + @tabela
	exec (@sql)
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
	return @error
end catch
go

-- procesure para inserir o usuário
create procedure sp_inserir_usuario
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
	return @error
end catch
go

-- inserir na tabela pessoa
create procedure sp_inserir_pessoa
	(
		@codigo_endereco int,
		@codigo_usuario int,
		@nome varchar(255),
		@genero varchar(255),
		@data_nascimento datetime,
		@idade int,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255)
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
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
			email
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
			@email
		)
	commit
	return scope_identity()
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	return @error
end catch
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
	return @error
end catch
go

-- procedure para inserir na tabela de aluno
create procedure sp_inserir_aluno
	(
		@codigo int,
		@nome varchar(255),
		@genero varchar(255),
		@data_nascimento datetime,
		@data_matricula datetime,
		@idade int,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@codigo_status int,
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
	declare @error varchar(100)

	select @error_code = @@error
begin try
		-- declaração de variáveis
		declare @existe_cpf int = 0
		declare @codigo_endereco int
		declare @codigo_pessoa int
		declare @codigo_responsavel int
		declare @codigo_usuario int

		set @existe_cpf = (select count(1) from pessoa where cpf = @cpf)

		if @existe_cpf > 0
		begin
			raiserror('O aluno a ser cadastrado já existe', 16, 1)
		end
		else
		begin
			begin tran
			-- inserir o endereço informado para obter o código_endereco para a tabela pessoa
			exec @codigo_endereco = sp_inserir_endereco @rua, @numero, @bairro, @cidade, @estado, @cep

			-- inserir na tabela usuario o email e a senha padrão 1234
			exec @codigo_usuario = sp_inserir_usuario @email

			-- inserir a pessoa para obter o código correspondente
			exec @codigo_pessoa = sp_inserir_pessoa  @codigo_endereco, @codigo_usuario, @nome, @genero, @data_nascimento, @idade, @rg, @cpf, @email

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
				@codigo_status,
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
	set @error = ERROR_MESSAGE()
	return @error
end catch
go

-- inserir na tabela professor
create procedure sp_inserir_professor
	(
		@codigo int,
		@nome varchar(255),
		@genero varchar(255),
		@data_nascimento datetime,
		@idade int,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@rua varchar(255),
		@numero int,
		@bairro varchar(255),
		@cidade varchar(255),
		@estado varchar(255),
		@cep int,
		@telefone varchar(255),
		@codigo_status int
	)
as
	declare @error_code int
	declare @error varchar(100)

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
			raiserror('Professor a ser cadastrado já existe', 16, 1)
		end
		else
		begin
			-- inserir na tabela endereco
			exec @codigo_endereco = sp_inserir_endereco @rua, @numero, @bairro, @cidade, @estado, @cep

			-- inserir na tabela usuario
			exec @codigo_usuario = sp_inserir_usuario @email

			-- inserir na tabela pessoa
			exec @codigo_pessoa = sp_inserir_pessoa @codigo_endereco, @codigo_usuario, @nome, @genero, @data_nascimento, @idade, @rg, @cpf, @email

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
				@codigo_status,
				@telefone
			)
		commit tran
		end

	select @error_code = 0
	return @error_code -- 0 se bem sucedido, diferente de 0 se falhar
end try
begin catch
	throw
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


create procedure sp_update_endereco
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
	return scope_identity()
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	return @error
end catch
go

-- procesure para inserir o usuário
create procedure sp_update_usuario
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
	return scope_identity()
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	return @error
end catch
go

-- inserir na tabela pessoa
create procedure sp_update_pessoa
	(
		@codigo_pessoa int,
		@nome varchar(255),
		@genero varchar(255),
		@data_nascimento datetime,
		@idade int,
		@email varchar(255)
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		-- declaração de variáveis
		declare @codigo_usuario_old int = (select codigo_usuario from pessoa where codigo = @codigo_pessoa)

		-- atualizar informações da tabela pessoa
		update pessoa
		set nome = @nome,
			genero = @genero,
			idade = @idade,
			email = @email
		where codigo = @codigo_pessoa

		-- atualizar informações da tabela usuário
		exec sp_update_usuario @codigo_usuario_old, @email
	commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	return @error
end catch
go

-- procedure para inserir na tabela responsável
create procedure sp_update_responsavel
	(
		@codigo_responsavel int,
		@nome_responsavel varchar(255),
		@telefone_responsavel varchar(255),
		@codigo_vinculo_responsavel int
	)
as
	declare @error_code int
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		update responsavel
		set nome = @nome_responsavel,
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
	return @error
end catch
go

-- atualizar a tabela aluno
create procedure sp_update_aluno
	(
		@codigo int,
		@nome varchar(255),
		@genero varchar(255),
		@data_nascimento datetime,
		@data_matricula datetime,
		@idade int,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@codigo_status int,
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
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		declare @existe_codigo int = (select count(1) from aluno where codigo = @codigo)
		declare @codigo_pessoa_old int = (select codigo_pessoa from aluno where codigo = @codigo)
		declare @codigo_escolaridade_old int = (select codigo_escolaridade from aluno where codigo = @codigo)
		declare @codigo_responsavel_old int = (select codigo_responsavel from aluno where codigo = @codigo)
		declare @codigo_endereco_old int = (select codigo_endereco from pessoa where codigo = @codigo_pessoa_old)

		-- atualizar o aluno
		update aluno
		set codigo_escolaridade = @codigo_escolaridade,
			codigo_status = @codigo_status,
			telefone = @telefone
		where codigo = @codigo

		-- atualizar os registros na tabela pessoa
		exec sp_update_pessoa @codigo_pessoa_old, @nome, @genero, @data_nascimento, @idade, @email

		-- atualizar os registros na tabela endereco
		exec sp_update_endereco @codigo_endereco_old, @rua, @numero, @bairro, @cidade, @estado, @cep

		-- atualizar os registros na tabela responsável
		exec sp_update_responsavel @codigo_responsavel_old, @nome_responsavel, @telefone_responsavel, @codigo_vinculo_responsavel
		commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	return @error
end catch
go

create procedure sp_update_professor
	(
		@codigo int,
		@nome varchar(255),
		@genero varchar(255),
		@data_nascimento datetime,
		@idade int,
		@rg varchar(255),
		@cpf varchar(255),
		@email varchar(255),
		@codigo_status int,
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
	declare @error varchar(100)

	select @error_code = @@error
begin try
	begin tran
		declare @codigo_pessoa_old int = (select codigo_pessoa from professor where codigo = @codigo)
		declare @codigo_endereco_old int = (select codigo_endereco from pessoa where codigo = @codigo_pessoa_old)

		-- atualizar o aluno
		update professor
		set codigo_status = @codigo_status,
			telefone = @telefone
		where codigo = @codigo

		-- atualizar os registros na tabela pessoa
		exec sp_update_pessoa @codigo_pessoa_old, @nome, @genero, @data_nascimento, @idade, @email

		-- atualizar os registros na tabela endereco
		exec sp_update_endereco @codigo_endereco_old, @rua, @numero, @bairro, @cidade, @estado, @cep
		commit
end try
begin catch
	if @@trancount > 0 rollback
	select @error_code = error_number()
	set @error = ERROR_MESSAGE()
	return @error
end catch
go

-- listagem de dados da tabela aluno
create procedure sp_listagem_aluno
as
begin
	select aluno.codigo,
		pessoa.nome,
		aluno.data_matricula,
		disciplina_aluno.descricao as descricao_disciplina,
		pessoa.genero,
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
		aluno.codigo_responsavel as codigo_vinculo_responsavel
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

-- listagem de dados da tabela professor
create procedure sp_listagem_professor
as
begin
	select professor.codigo,
		pessoa.nome,
		disciplina_professor.descricao as descricao_disciplina,
		pessoa.genero,
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
		professor.telefone
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

-- consulta para a tabela aluno
create procedure sp_consulta_aluno
	(
		@codigo int
	)
as
begin
	select aluno.codigo,
		pessoa.nome,
		aluno.data_matricula,
		disciplina_aluno.descricao as descricao_disciplina,
		pessoa.genero,
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
		aluno.codigo_responsavel as codigo_vinculo_responsavel
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

-- consulta para a tabela professor
create procedure sp_consulta_professor
	(
		@codigo int
	)
as
begin
	select professor.codigo,
		pessoa.nome,
		disciplina_professor.descricao as descricao_disciplina,
		pessoa.genero,
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
		professor.telefone
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

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

/* criação de functions */

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
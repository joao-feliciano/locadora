create database locadora
--char -telefone-cpf-rg é utilizando quando existe valores definidos - por exemplo CPF - precisa ser quantidade definida
--varchar é quando não tem uma quantidade definida 
--neste exercicio usar apenas varchar 
--serial -> autoincremento 
--numeric -> utilizar money 


--todo dependente tem que ser um cliente 

--quando é serial já é nulo 
CREATE TABLE endereco (
	cod_end SERIAL PRIMARY KEY, 
	logradouro varchar(40) not null,
	tipo_log varchar(40),
	complemento varchar(20),
	cidade varchar(60) not null, 
	uf varchar(2) not null,
	cep varchar(8) not null,
	numero varchar(10),
	bairro varchar(60) 
)

create table profissao(
	cod_prof SERIAL PRIMARY KEY,
	nome varchar(60)
)

create table cliente(
	cod_cli SERIAL PRIMARY KEY, 
	cpf varchar(11),
	nome varchar(60),
	telefone varchar(10),
	fk_cod_prof integer not null,
	foreign key (fk_cod_prof) references profissao(cod_prof)
)

--tabela associativa -> 2 clientes pode ter o mesmo endereço 
	--cod_cli esta associando os clientes com seus respectivos endereços 
create table cli_endereco(
	fk_cod_end integer not null,
	fk_cod_cli integer not null,
	primary key(fk_cod_end, fk_cod_cli),
	foreign key (fk_cod_end) references endereco(cod_end),
	foreign key (fk_cod_cli) references cliente(cod_cli)
)

CREATE TABLE dependente(
	fk_cod_cli integer not null, --chave primaria composta - combinação do cod_cli com o cod_dep nao se repita 
	fk_cod_dep integer not null,
	primary key(fk_cod_cli, fk_cod_dep),
	foreign key (fk_cod_cli) references cliente(cod_cli),
	foreign key (fk_cod_dep) references cliente(cod_cli),
	parentesco varchar(20)
)

CREATE TABLE categoria(
	cod_cat SERIAL primary key,
	nome varchar(60),
	valor money
)

CREATE TABLE genero(
	cod_gen SERIAL primary key,
	nome varchar(60)
)

CREATE TABLE ator(
	cod_ator SERIAL primary key, 
	nome varchar(60)
)

CREATE TABLE filmes(
	cod_filme SERIAL primary key,
	titulo_original varchar(100),
	titulo varchar(100),
	quantidade int,
	fk_cod_cat integer not null,
	fk_cod_gen integer not null,
	foreign key (fk_cod_cat) references categoria(cod_cat)
	foreign key (fk_cod_gen) references genero(cod_gen) 
)

CREATE TABLE filme_ator(
	fk_cod_ator integer not null,
	fk_cod_filme integer not null,
	primary key(fk_cod_ator, fk_cod_filme),
	foreign key(fk_cod_ator) references ator(cod_ator),
	foreign key (fk_cod_filme) references filmes(cod_filme),
	diretor varchar(1)
)

CREATE TABLE locacao(
	cod_loc SERIAL primary key,
	data_loc date,
	desconto money,
	multa money,
	sub_total money,
	fk_cod_cli integer not null,
	foreign key (fk_cod_cli) references cliente(cod_cli)
)

CREATE TABLE locacao_filme(
	fk_cod_loc integer not null,
	fk_cod_filme integer not null,
	primary key(fk_cod_loc, fk_cod_filme),
	valor money,
	num_dias int,
	data_devol date
)

INSERT INTO profissao (nome) VALUES
('Desenvolvedor Junior'), 
('Desenvolvedor Pleno'),
('Desenvolvedor Senior');

select * from profissao
			
INSERT INTO endereco (logradouro, tipo_log, complemento, cidade, uf, cep, numero, bairro) VALUES
('Rua dos bobos', 'Residencial', 'Apto 101', 'Cidade A', 'SP', '12345678', '0', 'Bairro A'),
('Rua dos Alfeneieros', 'Comercial', 'Loja 2', 'Cidade B', 'RJ', '87654321', '4', 'Bairro B'),
('Rua sem nome', 'Residencial', 'Casa', 'Cidade C', 'MG', '13579135', '30', 'Bairro C');

select * from endereco
delete from cliente where cod_cli = 16
INSERT INTO cliente (cpf, nome, telefone, fk_cod_prof) VALUES
('12345678901', 'Axl Rose', '999999999', 1),
('12345678902', 'Freddie Mercury', '988888888', 2),
('12345678903', 'Paul McCartney', '977777777', 3),
('12345678904', 'John Lennon', '966666666', 1),
('12345678905', 'John Escrevennon', '955555555', 2),
('12345678906', 'Elton John', '944444444', 3),
('12345678907', 'Chester Bennington', '933333333', 1),
('12345678908', 'Steven Tyler', '922222222', 2),
('12345678909', 'Bon Scott', '911111111', 3),
('12345678910', 'Mau Scott', '900000000', 1);

select * from cliente

INSERT INTO cli_endereco (fk_cod_end, fk_cod_cli) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 4),
(2, 5),
(3, 6),
(1, 7),
(2, 8),
(3, 9),
(1, 10);

select * from cli_endereco
delete from categoria where cod_cat = 10
INSERT INTO categoria (nome, valor) VALUES
('Ação', 10.00),
('Comédia', 8.00),
('Drama', 9.00),
('Ficção Científica', 12.00),
('Terror', 7.00);

select * from categoria
	
delete from genero where cod_gen = 6
delete from genero where cod_gen = 7
delete from genero where cod_gen = 8
delete from genero where cod_gen = 9
delete from genero where cod_gen = 10
INSERT INTO genero (nome) VALUES
('Aventura'),
('Comédia'),
('Drama'),
('Ficção Científica'),
('Terror');

select * from genero
delete from ator where cod_ator = 6
delete from ator where cod_ator = 7
delete from ator where cod_ator = 8
delete from ator where cod_ator = 9
delete from ator where cod_ator = 10
INSERT INTO ator (nome) VALUES
('Robert Downey Jr.'),
('Chris Evans'),
('Scarlett Johansson'),
('Mark Ruffalo'),
('Chris Hemsworth');

select * from ator

INSERT INTO filmes (titulo_original, titulo, quantidade, fk_cod_cat, fk_cod_gen) VALUES
('The Avengers', 'Os Vingadores', 10, 1, 1),
('Iron Man', 'Homem de Ferro', 5, 1, 1),
('Thor', 'Thor', 7, 1, 1),
('Captain America', 'Capitão América', 6, 1, 1),
('The Hulk', 'O Hulk', 4, 1, 1),
('Black Widow', 'Viúva Negra', 8, 1, 3),
('Ant-Man', 'Homem-Formiga', 3, 1, 1),
('Guardians of the Galaxy', 'Guardiões da Galáxia', 9, 1, 4),
('Doctor Strange', 'Doutor Estranho', 7, 1, 4),
('Spider-Man', 'Homem-Aranha', 5, 1, 1),
('Avengers: Age of Ultron', 'Vingadores: Era de Ultron', 6, 1, 1),
('Avengers: Infinity War', 'Vingadores: Guerra Infinita', 7, 1, 1),
('Avengers: Endgame', 'Vingadores: Ultimato', 8, 1, 1),
('Captain Marvel', 'Capitã Marvel', 4, 1, 3),
('Black Panther', 'Pantera Negra', 6, 1, 3);

select * from filmes

INSERT INTO filme_ator (fk_cod_ator, fk_cod_filme, diretor) VALUES
(1, 1, 'S'),
(2, 1, 'N'),
(3, 1, 'N'),
(4, 1, 'N'),
(5, 1, 'N'),
(1, 2, 'S'),
(2, 3, 'N'),
(3, 4, 'N'),
(4, 5, 'N'),
(5, 6, 'N');

select * from filme_ator

INSERT INTO locacao (data_loc, desconto, multa, sub_total, fk_cod_cli) VALUES
('2023-06-01', 2.00, 1.00, 7.00, 1),
('2023-06-02', 1.50, 0.50, 6.50, 2),
('2023-06-03', 3.00, 2.00, 10.00, 3),
('2023-06-04', 0.50, 0.1, 9.00, 4)

select * from locacao
delete from locacao_filme where fk_cod_loc = 1
INSERT INTO locacao_filme (fk_cod_loc, fk_cod_filme, valor, num_dias, data_devol) VALUES
(1, 1, 7.00, 5, '2023-06-06'),
(2, 2, 6.50, 4, '2023-06-06'),
(3, 3, 10.00, 7, '2023-06-10'),
(4, 4, 9.00, 6, '2023-06-10');


select * from locacao_filme






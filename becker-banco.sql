create database bancodedados_acme_becker;

use db_acme_filmes_becker;

create table tbl_classificacao (
id int not null auto_increment primary key,
faixa_etaria varchar(2) not null,
classificacao varchar(100) not null,
caracteristica varchar(100) not null,
icone varchar(45) not null
);

insert into tbl_classificacao (faixa_etaria, classificacao, caracteristica, icone) values
('L', 'Livre', 'Livre para todos os públicos', 'icone_livre.png'),
('10', '10 anos', 'Não recomendado para menores de 10 anos', 'icone_10anos.png'),
('12', '12 anos', 'Não recomendado para menores de 12 anos', 'icone_12anos.png'),
('14', '14 anos', 'Não recomendado para menores de 14 anos', 'icone_14anos.png'),
('16', '16 anos', 'Não recomendado para menores de 16 anos', 'icone_16anos.png'),
('18', '18 anos', 'Não recomendado para menores de 18 anos', 'icone_18anos.png');

create table tbl_filmee (
id int not null auto_increment primary key,
nome varchar (80) not null,
sinopse text not null, 
duracao time not null,
data_lancamento date not null,
data_relancamento date,
foto_capa varchar(300) not null,
valor_unitario float,
id_classificacao int not null, 
FOREIGN KEY (id_classificacao)
REFERENCES tbl_classificacao(id)
);


insert into tbl_filmee (nome, sinopse, duracao, data_lancamento, data_relancamento, foto_capa, valor_unitario, id_classificacao) values
("O Profissional",
 "Em Nova York o assassino profissional Leon (Jean Reno) não vê sentido na vida. Quando a família vizinha é morta por policiais envolvidos com drogas ele decide proteger Mathilda (Natalie Portman), uma menina de 12 anos que é a única sobrevivente da família.", 
 '01:30:00', 
 "1994-09-14", 
 NULL, 
 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.adorocinema.com%2Ffilmes%2Ffilme-9684%2F&psig=AOvVaw1ws2baAAIwTZKcG7kEXkkM&ust=1707335903309000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPjS_oDAl4QDFQAAAAAdAAAAABAE',
 '50.00',
 1
 ),
 ("Blade, o Caçador de Vampiros",
"Após ser contaminado pelo sangue de uma criatura das trevas, Blade (Wesley Snipes) transformou-se num guerreiro imortal, metade-homem, metade-vampiro. Desde então, ele dedica-se a caçar o líder dos mortos-vivos Deacon Frost (Stephen Dorff) e seus asseclas, que estão planejando um grande plano para aumentar sua dominação sobre a raça humana.",
 '02:00:00', 
 "1998-10-30", 
 NULL, 
"https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/93/16/78/20239701.jpg" ,
'80.00',
 2
 ),
 
 ("Blade 2",
"Blade (Wesley Snipes) é um ser meio homem, meio vampiro que é consumido pelo desejo de vingança contra os seres que atacaram sua mãe antes mesmo dele nascer e fizeram com que ele se tornasse o que é atualmente. Com isso, ao crescer Blade iniciou uma verdadeira cruzada pessoal para combater e eliminar os vampiros, mas agora uma nova raça mais poderosa chamada reapers, criada a partir de cruzamentos genéticos entre humanos e vampiros, ameaça eliminar ambas as raças. Visto isso, Blade se alia aos seus maiores inimigos para que, juntos, possam combater esta nova raça de seres.",
 '02:20:00', 
 "2002-06-21", 
 NULL, 
"https://br.web.img2.acsta.net/c_310_420/medias/nmedia/18/93/16/84/20239732.jpg" ,
'80.00',
 3
 );

select * from tbl_filmee;

create table tbl_genero (
id int not null auto_increment primary key,
nome varchar(45) not null
);

insert into tbl_genero (nome) values
("Terror"),
("Drama"),
("Suspense"),
("Ação"),
("Romance"),
("Documentário"),
("Animação"),
("Musical"),
("Fantasia"),
("Comédia"),
("Aventura"),
("Ficção Científica");

create table tbl_filme_genero (
id int not null auto_increment primary key,
id_filme int not null, 
FOREIGN KEY (id_filme)
REFERENCES tbl_filmee(id),
id_genero int not null, 
FOREIGN KEY (id_genero)
REFERENCES tbl_genero(id)
);

create table tbl_sexo (
id int not null auto_increment primary key,
sigla varchar(1) not null, 
nome varchar(20) not null
);

insert into tbl_sexo (sigla, nome) values
('M', 'Masculino'),
('F', 'Feminino');


create table tbl_ator (
id int not null auto_increment primary key,
nome varchar(100) not null,
nome_artistico varchar(100) not null,
foto varchar(150) not null,
data_nascimento date not null,
data_falecimento date,
biografia text not null,
sexo varchar(1) not null,
id_sexo int not null,
FOREIGN KEY (id_sexo)
REFERENCES tbl_sexo (id)
);

drop table tbl_ator;

insert into tbl_ator (nome, nome_artistico, foto, data_nascimento, data_falecimento, biografia, sexo, id_sexo) values
('Will Smith',
'Will Smith',
'will_smith.jpg',
'1968-09-25',
NULL,
'Um ator renomado conhecido por seus papéis em filmes como Independence Day, Homens de Preto e À Procura da Felicidade.',
'M',
1),

('Leonardo DiCaprio',
'Leonardo DiCaprio',
'leonardo_dicaprio.jpg',
'1974-11-11',
NULL,
'Um ator renomado conhecido por seus papéis em filmes como Titanic, A Origem e O Lobo de Wall Street.',
'M',
2),

('Emma Watson',
'Emma Watson',
'emma_watson.jpg',
'1990-04-15',
NULL,
'Uma atriz renomada conhecida por seu papel como Hermione Granger na série de filmes Harry Potter, além de seu ativismo em questões de igualdade de gênero.',
'F',
3);



create table tbl_diretor (
id int not null auto_increment primary key,
nome varchar(100) not null,
nome_artistico varchar(100) not null,
foto varchar(150) not null,
data_nascimento date not null,
data_falecimento date,
biografia text not null,
sexo varchar(1) not null,
id_sexo int not null,
FOREIGN KEY (id_sexo)
REFERENCES tbl_sexo (id)
);

insert into tbl_diretor (nome, nome_artistico, foto, data_nascimento, data_falecimento, biografia, sexo, id_sexo)values 
('Quentin Tarantino', 
'Quentin Tarantino', 
'quentin_tarantino.jpg', 
'1963-03-27', 
NULL, 
'Diretor renomado conhecido por filmes como Pulp Fiction e Kill Bill.', 
'M', 
1),

('Brian De Palma',
'Brian De Palma',
'brian_de_palma.jpg',
'1940-09-11',
NULL,
'Um renomado diretor de cinema conhecido por seus filmes como Scarface, Os Intocáveis e Carrie - A Estranha.',
'M',
2);



create table tbl_nacionalidade (
id int not null auto_increment primary key,
nome varchar(45) not null
);

INSERT INTO tbl_nacionalidade (nome) VALUES
('Brasileiro (a)'),
('Espanhol (a)'),
('Canadense (a)'),
('Russo (a)'),
('Chinês (a)');


create table tbl_ator_nacionalidade (
id int not null auto_increment primary key,
id_ator int not null,
id_nacionalidade int not null,
FOREIGN KEY (id_ator)
REFERENCES tbl_ator (id),
FOREIGN KEY (id_nacionalidade)
REFERENCES tbl_nacionalidade (id)
);

create table tbl_diretor_nacionalidade (
id int not null,
id_diretor int not null,
id_nacionalidade int not null,
FOREIGN KEY (id_diretor)
REFERENCES tbl_diretor (id),
FOREIGN KEY (id_nacionalidade)
REFERENCES tbl_nacionalidade (id)
);

create table tbl_filme_ator (
id int not null auto_increment primary key,
id_ator int not null,
id_filme int not null,
FOREIGN KEY (id_ator)
REFERENCES tbl_ator (id),
FOREIGN KEY (id_filme)
REFERENCES tbl_filmee (id)
);

create table tbl_filme_diretor (
id int not null auto_increment primary key,
id_diretor int not null,
id_filme int not null,
FOREIGN KEY (id_diretor)
REFERENCES tbl_diretor (id),
FOREIGN KEY (id_filme)
REFERENCES tbl_filmee (id)
);


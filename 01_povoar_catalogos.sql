PRAGMA foreign_keys = ON;
-- Catálogo de Modalidade
insert or ignore into Modalidade (id, nome) values (1, 'EAD/Remoto');
insert or ignore into Modalidade (id, nome) values (2, 'Semi Presencial');
insert or ignore into Modalidade (id, nome) values (3, 'Presencial');

-- Catálogo de Habilidades
insert or ignore into Habilidade (id, nome) values (1, 'Python');
insert or ignore into Habilidade (id, nome) values (2, 'Java');
insert or ignore into Habilidade (id, nome) values (3, 'JavaScript');
insert or ignore into Habilidade (id, nome) values (4, 'SQL');
insert or ignore into Habilidade (id, nome) values (5, 'C#');
insert or ignore into Habilidade (id, nome) values (6, 'C++');
insert or ignore into Habilidade (id, nome) values (7, 'PHP');
insert or ignore into Habilidade (id, nome) values (8, 'Ruby');
insert or ignore into Habilidade (id, nome) values (9, 'Go');
insert or ignore into Habilidade (id, nome) values (10, 'Swift');
insert or ignore into Habilidade (id, nome) values (11, 'Kotlin');
insert or ignore into Habilidade (id, nome) values (12, 'R');
insert or ignore into Habilidade (id, nome) values (13, 'TypeScript');
insert or ignore into Habilidade (id, nome) values (14, 'React');
insert or ignore into Habilidade (id, nome) values (15, 'Angular');
insert or ignore into Habilidade (id, nome) values (16, 'Node');
insert or ignore into Habilidade (id, nome) values (17, 'FastAPI');
insert or ignore into Habilidade (id, nome) values (18, 'Docker');
insert or ignore into Habilidade (id, nome) values (19, 'Excel');
insert or ignore into Habilidade (id, nome) values (20, 'Pandas');
insert or ignore into Habilidade (id, nome) values (21, 'Terraform');
insert or ignore into Habilidade (id, nome) values (22, 'Kubernetes');
insert or ignore into Habilidade (id, nome) values (23, 'AWS');

-- Catálogo de Fontes de Origem
insert or ignore into Fonte (id, endereco_url) values (1, 'https://www.linkedin.com');
insert or ignore into Fonte (id, endereco_url) values (2, 'https://www.gupy.io');
insert or ignore into Fonte (id, endereco_url) values (3, 'https://www.empresa.com/vagas');

-- Catálogo de NívelConhecimento
insert or ignore into NivelConhecimento (id, descricao) values (1, 'Básico');
insert or ignore into NivelConhecimento (id, descricao) values (2, 'Intermediário');
insert or ignore into NivelConhecimento (id, descricao) values (3, 'Avançado');
insert or ignore into NivelConhecimento (id, descricao) values (4, 'Especialista');

-- Catálogo de Área de Estudo
insert or ignore into AreaEstudo (id, nome) values (1, 'Ciência da Computação');
insert or ignore into AreaEstudo (id, nome) values (2, 'Engenharia de Software');
insert or ignore into AreaEstudo (id, nome) values (3, 'Sistemas de Informação');
insert or ignore into AreaEstudo (id, nome) values (4, 'Análise e Desenvolvimento de Sistemas');
insert or ignore into AreaEstudo (id, nome) values (5, 'Inteligência Artificial');
insert or ignore into AreaEstudo (id, nome) values (6, 'Ciência de Dados e Analytics');
insert or ignore into AreaEstudo (id, nome) values (7, 'Segurança da Informação');
insert or ignore into AreaEstudo (id, nome) values (8, 'Redes de Computadores');
insert or ignore into AreaEstudo (id, nome) values (9, 'Banco de Dados');
insert or ignore into AreaEstudo (id, nome) values (10, 'Desenvolvimento Web');
insert or ignore into AreaEstudo (id, nome) values (11, 'Desenvolvimento Mobile');
insert or ignore into AreaEstudo (id, nome) values (12, 'Infraestrutura e DevOps');
insert or ignore into AreaEstudo (id, nome) values (13, 'Computação em Nuvem');
insert or ignore into AreaEstudo (id, nome) values (14, 'Design e Experiência do Usuário(UI/UX)');
insert or ignore into AreaEstudo (id, nome) values (15, 'Gestão de Produtos e Projetos de TI');

-- Catálogo de StatusOportunidade
insert or ignore into StatusOportunidade (id, nome) values (1, 'Previsto');
insert or ignore into StatusOportunidade (id, nome) values (2, 'Inscrições Abertas');
insert or ignore into StatusOportunidade (id, nome) values (3, 'Inscrições Encerradas');
insert or ignore into StatusOportunidade (id, nome) values (4, 'Em Andamento');
insert or ignore into StatusOportunidade (id, nome) values (5, 'Processo pausado');
insert or ignore into StatusOportunidade (id, nome) values (6, 'Processo cancelado');
insert or ignore into StatusOportunidade (id, nome) values (7, 'Processo concluído');

select * from Modalidade;
select * from Habilidade;
select * from Fonte;
select * from NivelConhecimento;
select * from AreaEstudo;
select * from StatusOportunidade;

TECH OPPORTUNITIES HUB — BANCO DE DADOS

1. VISÃO GERAL E ESTADO ATUAL

Status: Modelagem Física (DDL), povoamento integral dos catálogos (01_povoar_catalogos.sql), inserção de dados de teste (02_povoar_dados_teste.sql) e consultas relacionais de validação concluídas com sucesso.   

Arquivo DDL Principal: schema.sql (Contém a estrutura das tabelas, PKs, FKs, constraints e tipos de dados).   

Scripts de Carga: 01_povoar_catalogos.sql (Popula os 6 catálogos de domínio) e 02_povoar_dados_teste.sql (Popula candidatos, empresas, vagas, inscrições e históricos para testes).   

Validação: Constraints de integridade, chaves compostas e junções (JOINs) executadas e aprovadas no SQLite.

2. ESTRUTURA E CATEGORIZAÇÃO DAS TABELAS
Tabelas de Domínio (Catálogos)
Tabelas estáticas/cadastrais sem dependências externas, utilizadas para padronização de dados:

Modalidade (id PK, nome) — Ex: EAD/Remoto, Semi Presencial, Presencial.   
Habilidade (id PK, nome) — Ex: Python, Java, Docker, SQL, AWS (Substituiu formalmente a entidade "Tecnologia").   
Fonte (id PK, endereco_url UNIQUE) — Ex: URLs de origens das vagas.  
NivelConhecimento (id PK, descricao UNIQUE) — Ex: Básico, Intermediário, Avançado, Especialista.   
AreaEstudo (id PK, nome) — Ex: Engenharia de Software, Ciência de Dados, DevOps.   
StatusOportunidade (id PK, nome) — Ex: Inscrições Abertas, Previsto, Processo Concluído.   

Entidades Principais (Fortes)
Entidades transacionais centrais do domínio:   

Usuario (id PK, nome, email UNIQUE, senha, objetivo) — Armazena candidatos com suporte a hashes seguros.   
Empresa (id PK, nome) — Armazena as empresas anunciantes.   
Oportunidade (id PK, titulo, descricao, requisitos, data_final_inscricao, modalidade_id FK, area_de_estudo_id FK, nivel_conhecimento_id FK, status_oportunidade_id FK, data_ultima_atualizacao) — Vagas cadastradas.   

Tabelas Associativas (Relações N:N com Chaves Compostas)
Tabelas que resolvem relacionamentos muitos-para-muitos e garantem integridade contra duplicações:   

UsuarioHabilidade (usuario_id FK, habilidade_id FK, nivelconhecimento_id FK) — PK Composta: (usuario_id, habilidade_id).   
EmpresaOportunidade (empresa_id FK, oportunidade_id FK) — PK Composta: (empresa_id, oportunidade_id).   
Inscricao (usuario_id FK, oportunidade_id FK) — PK Composta: (usuario_id, oportunidade_id). Impede inscrição duplicada na mesma vaga.   
HabilidadeOportunidade (oportunidade_id FK, habilidade_id FK) — PK Composta: (oportunidade_id, habilidade_id).   
OportunidadeFonte (oportunidade_id FK, fonte_id FK) — PK Composta: (oportunidade_id, fonte_id). Associa N origens a uma mesma oportunidade.   

Histórico e Rastreabilidade
Tabelas para auditoria e acompanhamento evolutivo do estudante:   

ExperienciaUsuario (id PK, usuario_id FK, cargo, empresa_nome, data_inicio, data_fim, descricao) — Trajetória profissional do candidato.   
HistoricoStatus (id PK, usuario_id FK, oportunidade_id FK, status, data_mudanca) — Linha do tempo das etapas de seleção do candidato.   

3. REGRAS DE INTEGRIDADE E CONFIGURAÇÕES TÉCNICAS
Ativação de FKs: Todos os scripts iniciam com PRAGMA foreign_keys = ON; para forçar a validação de integridade referencial pelo SQLite.   

Idempotência (INSERT OR IGNORE): Cláusula utilizada nos scripts de carga para permitir reexecuções sem gerar falhas por duplicação de chave.   

Bloqueio de Duplicidade: O uso de chaves primárias compostas nas tabelas associativas barra nativamente registros idênticos no banco.   

Segurança de Senha: A coluna senha em Usuario possui tamanho varchar(255) adequado para armazenar hashes gerados por algoritmos seguros (ex: Bcrypt / Argon2).   

4. SCRIPTS SQL DO PROJETO
***Script DDL (schema.sql)

PRAGMA foreign_keys = ON;

CREATE TABLE "Usuario" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "nome" varchar(100) NOT NULL,
  "email" varchar(100) UNIQUE NOT NULL,
  "senha" varchar(255) NOT NULL,
  "objetivo" varchar(255)
);

CREATE TABLE "Empresa" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "nome" varchar(150) NOT NULL
);

CREATE TABLE "Modalidade" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "nome" varchar(100) NOT NULL
);

CREATE TABLE "Fonte" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "endereco_url" varchar(255) UNIQUE NOT NULL
);

CREATE TABLE "NivelConhecimento" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "descricao" varchar(255) UNIQUE NOT NULL
);

CREATE TABLE "AreaEstudo" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "nome" varchar(150) NOT NULL
);

CREATE TABLE "StatusOportunidade" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "nome" varchar(100) NOT NULL
);

CREATE TABLE "Habilidade" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "nome" varchar(100) NOT NULL
);

CREATE TABLE "Oportunidade" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "titulo" varchar(150) NOT NULL,
  "descricao" text NOT NULL,
  "requisitos" text,
  "data_final_inscricao" timestamp,
  "modalidade_id" int NOT NULL,
  "area_de_estudo_id" int NOT NULL,
  "nivel_conhecimento_id" int NOT NULL,
  "status_oportunidade_id" int NOT NULL,
  "data_ultima_atualizacao" datetime NOT NULL,
  FOREIGN KEY ("modalidade_id") REFERENCES "Modalidade" ("id"),
  FOREIGN KEY ("area_de_estudo_id") REFERENCES "AreaEstudo" ("id"),
  FOREIGN KEY ("nivel_conhecimento_id") REFERENCES "NivelConhecimento" ("id"),
  FOREIGN KEY ("status_oportunidade_id") REFERENCES "StatusOportunidade" ("id")
);

CREATE TABLE "UsuarioHabilidade" (
  "usuario_id" int,
  "habilidade_id" int,
  "nivelconhecimento_id" int,
  PRIMARY KEY ("usuario_id", "habilidade_id"),
  FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id"),
  FOREIGN KEY ("habilidade_id") REFERENCES "Habilidade" ("id"),
  FOREIGN KEY ("nivelconhecimento_id") REFERENCES "NivelConhecimento" ("id")
);

CREATE TABLE "EmpresaOportunidade" (
  "empresa_id" int,
  "oportunidade_id" int,
  PRIMARY KEY ("empresa_id", "oportunidade_id"),
  FOREIGN KEY ("empresa_id") REFERENCES "Empresa" ("id"),
  FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id")
);

CREATE TABLE "Inscricao" (
  "usuario_id" int,
  "oportunidade_id" int,
  PRIMARY KEY ("usuario_id", "oportunidade_id"),
  FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id"),
  FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id")
);

CREATE TABLE "HabilidadeOportunidade" (
  "oportunidade_id" int,
  "habilidade_id" int,
  PRIMARY KEY ("oportunidade_id", "habilidade_id"),
  FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id"),
  FOREIGN KEY ("habilidade_id") REFERENCES "Habilidade" ("id")
);

CREATE TABLE "OportunidadeFonte" (
  "oportunidade_id" int,
  "fonte_id" int,
  PRIMARY KEY ("oportunidade_id", "fonte_id"),
  FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id"),
  FOREIGN KEY ("fonte_id") REFERENCES "Fonte" ("id")
);

CREATE TABLE "ExperienciaUsuario" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "usuario_id" int,
  "cargo" varchar(100),
  "empresa_nome" varchar(150),
  "data_inicio" date,
  "data_fim" date,
  "descricao" text,
  FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id")
);

CREATE TABLE "HistoricoStatus" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "usuario_id" int,
  "oportunidade_id" int,
  "status" varchar(100) NOT NULL,
  "data_mudanca" datetime NOT NULL,
  FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id"),
  FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id")
);


***Script de Povoamento de Catálogos (01_povoar_catalogos.sql)

PRAGMA foreign_keys = ON;

-- Modalidade
INSERT OR IGNORE INTO Modalidade (id, nome) VALUES (1, 'EAD/Remoto');
INSERT OR IGNORE INTO Modalidade (id, nome) VALUES (2, 'Semi Presencial');
INSERT OR IGNORE INTO Modalidade (id, nome) VALUES (3, 'Presencial');

-- Habilidades
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (1, 'Python');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (2, 'Java');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (3, 'JavaScript');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (4, 'SQL');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (5, 'C#');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (6, 'C++');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (7, 'PHP');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (8, 'Ruby');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (9, 'Go');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (10, 'Swift');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (11, 'Kotlin');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (12, 'R');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (13, 'TypeScript');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (14, 'React');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (15, 'Angular');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (16, 'Node');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (17, 'FastAPI');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (18, 'Docker');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (19, 'Excel');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (20, 'Pandas');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (21, 'Terraform');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (22, 'Kubernetes');
INSERT OR IGNORE INTO Habilidade (id, nome) VALUES (23, 'AWS');

-- Fontes de Origem
INSERT OR IGNORE INTO Fonte (id, endereco_url) VALUES (1, 'https://www.linkedin.com');
INSERT OR IGNORE INTO Fonte (id, endereco_url) VALUES (2, 'https://www.gupy.io');
INSERT OR IGNORE INTO Fonte (id, endereco_url) VALUES (3, 'https://www.empresa.com/vagas');

-- Nível de Conhecimento
INSERT OR IGNORE INTO NivelConhecimento (id, descricao) VALUES (1, 'Básico');
INSERT OR IGNORE INTO NivelConhecimento (id, descricao) VALUES (2, 'Intermediário');
INSERT OR IGNORE INTO NivelConhecimento (id, descricao) VALUES (3, 'Avançado');
INSERT OR IGNORE INTO NivelConhecimento (id, descricao) VALUES (4, 'Especialista');

-- Área de Estudo
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (1, 'Ciência da Computação');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (2, 'Engenharia de Software');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (3, 'Sistemas de Informação');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (4, 'Análise e Desenvolvimento de Sistemas');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (5, 'Inteligência Artificial');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (6, 'Ciência de Dados e Analytics');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (7, 'Segurança da Informação');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (8, 'Redes de Computadores');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (9, 'Banco de Dados');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (10, 'Desenvolvimento Web');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (11, 'Desenvolvimento Mobile');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (12, 'Infraestrutura e DevOps');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (13, 'Computação em Nuvem');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (14, 'Design e Experiência do Usuário(UI/UX)');
INSERT OR IGNORE INTO AreaEstudo (id, nome) VALUES (15, 'Gestão de Produtos e Projetos de TI');

-- Status da Oportunidade
INSERT OR IGNORE INTO StatusOportunidade (id, nome) VALUES (1, 'Previsto');
INSERT OR IGNORE INTO StatusOportunidade (id, nome) VALUES (2, 'Inscrições Abertas');
INSERT OR IGNORE INTO StatusOportunidade (id, nome) VALUES (3, 'Inscrições Encerradas');
INSERT OR IGNORE INTO StatusOportunidade (id, nome) VALUES (4, 'Em Andamento');
INSERT OR IGNORE INTO StatusOportunidade (id, nome) VALUES (5, 'Processo pausado');
INSERT OR IGNORE INTO StatusOportunidade (id, nome) VALUES (6, 'Processo cancelado');
INSERT OR IGNORE INTO StatusOportunidade (id, nome) VALUES (7, 'Processo concluído');


****Script de Dados de Teste (02_povoar_dados_teste.sql)

PRAGMA foreign_keys = ON;

-- Usuários
INSERT OR IGNORE INTO Usuario (id, nome, email, senha, objetivo) VALUES (1, 'João Silva', 'joao.silva@example.com', '$2y$10$simulacaoHashSeguroParaSenha123', 'Desenvolvedor Python');
INSERT OR IGNORE INTO Usuario (id, nome, email, senha, objetivo) VALUES (2, 'Maria Oliveira', 'maria.oliveira@example.com', '$2y$10$simulacaoHashSeguroParaSenha123', 'Designer UI/UX');
INSERT OR IGNORE INTO Usuario (id, nome, email, senha, objetivo) VALUES (3, 'Carlos Souza', 'carlos.souza@example.com', '$2y$10$simulacaoHashSeguroParaSenha123', 'Analista de Dados');
INSERT OR IGNORE INTO Usuario (id, nome, email, senha, objetivo) VALUES (4, 'Ana Costa', 'ana.costa@example.com', '$2y$10$simulacaoHashSeguroParaSenha123', 'Engenheira de Software');
INSERT OR IGNORE INTO Usuario (id, nome, email, senha, objetivo) VALUES (5, 'Pedro Lima', 'pedro.lima@example.com', '$2y$10$simulacaoHashSeguroParaSenha123', 'Desenvolvedor Mobile');

-- Empresas
INSERT OR IGNORE INTO Empresa (id, nome) VALUES (1, 'TechNova Solutions'), (2, 'DataCorp Analytics'), (3, 'CloudSys Web Services');

-- Oportunidades
INSERT OR IGNORE INTO Oportunidade (
    id, titulo, descricao, requisitos, data_final_inscricao, 
    modalidade_id, area_de_estudo_id, nivel_conhecimento_id, status_oportunidade_id, data_ultima_atualizacao
) VALUES 
(1, 'Desenvolvedor Backend Python', 'Atuação na construção de microsserviços e APIs REST.', 'Python, FastAPI, Docker, SQL', '2026-09-01 23:59:59', 1, 10, 2, 2, CURRENT_TIMESTAMP),
(2, 'Estágio em Análise de Dados', 'Auxiliar na limpeza e visualização de dados de marketing.', 'SQL básico, Excel, Python (Pandas)', '2026-08-30 23:59:59', 3, 6, 1, 2, CURRENT_TIMESTAMP),
(3, 'Engenheiro Cloud AWS Especialista', 'Liderar migração de infraestrutura legada para nuvem AWS.', 'AWS, Terraform, Kubernetes, CI/CD', '2026-09-15 23:59:59', 1, 12, 4, 2, CURRENT_TIMESTAMP);

-- Inscrições
INSERT OR IGNORE INTO Inscricao (usuario_id, oportunidade_id) VALUES 
(1, 1),
(2, 2),
(1, 3),
(1, 1); -- Rejeitado/Ignorado por chave composta duplicada

-- Habilidades de Usuários
INSERT OR IGNORE INTO UsuarioHabilidade (usuario_id, habilidade_id, nivelconhecimento_id) VALUES 
(1, 1, 3),
(1, 2, 2),
(2, 2, 1);

-- Requisitos das Vagas
INSERT OR IGNORE INTO HabilidadeOportunidade (oportunidade_id, habilidade_id) VALUES 
(1, 1),
(1, 2),
(2, 2);

-- Vagas por Empresa
INSERT OR IGNORE INTO EmpresaOportunidade (empresa_id, oportunidade_id) VALUES 
(1, 1),
(2, 2),
(3, 3);

-- Origem das Vagas
INSERT OR IGNORE INTO OportunidadeFonte (oportunidade_id, fonte_id) VALUES 
(1, 1),
(1, 2),
(2, 1);

-- Histórico de Fases do Candidato
INSERT OR IGNORE INTO HistoricoStatus (usuario_id, oportunidade_id, status, data_mudanca) VALUES 
(1, 1, 'Inscrito', '2026-01-01 00:00:00'),
(1, 1, 'Em análise', '2026-01-05 00:00:00'),
(1, 1, 'Aprovado', '2026-01-10 00:00:00'),
(2, 2, 'Inscrito', '2026-01-02 00:00:00'),
(2, 2, 'Reprovado', '2026-01-06 00:00:00');

-- Histórico Profissional
INSERT OR IGNORE INTO ExperienciaUsuario (usuario_id, cargo, empresa_nome, data_inicio, data_fim, descricao) VALUES 
(1, 'Desenvolvedor Junior', 'TechNova Solutions', '2024-01-01', '2025-01-01', 'Trabalhou no desenvolvimento de APIs e microsserviços.'),
(2, 'Analista de Dados', 'DataCorp Analytics', '2023-06-01', '2024-06-01', 'Responsável por análises de dados e criação de dashboards.'),
(3, 'Engenheiro de Software', 'CloudSys Web Services', '2022-03-01', NULL, 'Atua na arquitetura e desenvolvimento de soluções em nuvem.');
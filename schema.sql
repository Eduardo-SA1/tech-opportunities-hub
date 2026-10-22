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

CREATE TABLE "UsuarioHabilidade" (
  "usuario_id" int,
  "habilidade_id" int,
  "nivelconhecimento_id" int,
  PRIMARY KEY ("usuario_id", "habilidade_id"),
  FOREIGN KEY ("habilidade_id") REFERENCES "Habilidade" ("id"),
  FOREIGN KEY ("nivelconhecimento_id") REFERENCES "NivelConhecimento" ("id")
);

CREATE TABLE "EmpresaOportunidade" (
  "empresa_id" int,
  "oportunidade_id" int,
  PRIMARY KEY ("empresa_id", "oportunidade_id")
  FOREIGN KEY ("empresa_id") REFERENCES "Empresa" ("id"),
  FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id")
);

CREATE TABLE "Inscricao" (
  "usuario_id" int,
  "oportunidade_id" int,
  PRIMARY KEY ("usuario_id", "oportunidade_id")
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
  PRIMARY KEY ("oportunidade_id", "fonte_id")
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
  "descricao" text
);

CREATE TABLE "HistoricoStatus" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "usuario_id" int,
  "oportunidade_id" int,
  "status" varchar(100) NOT NULL,
  "data_mudanca" datetime NOT NULL
);

-- ALTER TABLE "UsuarioHabilidade" ADD FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id") DEFERRABLE INITIALLY IMMEDIATE;

-- ALTER TABLE "UsuarioHabilidade" ADD FOREIGN KEY ("habilidade_id") REFERENCES "Habilidade" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "UsuarioHabilidade" ADD FOREIGN KEY ("nivelconhecimento_id") REFERENCES "NivelConhecimento" ("id") DEFERRABLE INITIALLY IMMEDIATE;
--ALTER TABLE "Inscricao" ADD FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id") DEFERRABLE INITIALLY IMMEDIATE;
--ALTER TABLE "Inscricao" ADD FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "HabilidadeOportunidade" ADD FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id") DEFERRABLE INITIALLY IMMEDIATE;

-- ALTER TABLE "HabilidadeOportunidade" ADD FOREIGN KEY ("habilidade_id") REFERENCES "Habilidade" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "OportunidadeFonte" ADD FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "OportunidadeFonte" ADD FOREIGN KEY ("fonte_id") REFERENCES "Fonte" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "EmpresaOportunidade" ADD FOREIGN KEY ("empresa_id") REFERENCES "Empresa" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "EmpresaOportunidade" ADD FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "HistoricoStatus" ADD FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "HistoricoStatus" ADD FOREIGN KEY ("oportunidade_id") REFERENCES "Oportunidade" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "Oportunidade" ADD FOREIGN KEY ("modalidade_id") REFERENCES "Modalidade" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "Oportunidade" ADD FOREIGN KEY ("area_de_estudo_id") REFERENCES "AreaEstudo" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "Oportunidade" ADD FOREIGN KEY ("nivel_conhecimento_id") REFERENCES "NivelConhecimento" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "Oportunidade" ADD FOREIGN KEY ("status_oportunidade_id") REFERENCES "StatusOportunidade" ("id") DEFERRABLE INITIALLY IMMEDIATE;

--ALTER TABLE "ExperienciaUsuario" ADD FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id") DEFERRABLE INITIALLY IMMEDIATE;
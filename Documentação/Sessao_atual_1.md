TECH OPPORTUNITIES HUB — DOCUMENTAÇÃO DE SESSÃO E ARQUITETURA

1. DOCUMENTAÇÃO DETALHADA DA SESSÃO ATUAL

Estado do Projeto

Projeto Ativo: Tech Opportunities Hub

Fase Atual: Finalização do Povoamento do Banco de Dados e Validação de Queries Relacionais (Ambiente de Desenvolvimento - SQLite).

Progresso: Transição concluída com sucesso da fase de scripts DDL (schema.sql) para o povoamento e validação relacional via scripts SQL (01_povoar_catalogos.sql e 02_povoar_dados_teste.sql).

Atividades Concluídas nesta Sessão
Completa Inserção das Tabelas de Catálogo (01_povoar_catalogos.sql)
População integral dos 6 catálogos de domínio do sistema com clausula INSERT OR IGNORE:

Modalidade: EAD/Remoto, Semi Presencial, Presencial.
Habilidade: 23 competências técnicas (Python, Java, JavaScript, SQL, Docker, AWS, Kubernetes, etc.).
Fonte: URLs de origem padronizadas (LinkedIn, Gupy, Páginas Internas).
NivelConhecimento: Básico, Intermediário, Avançado, Especialista.
AreaEstudo: 15 áreas do conhecimento em TI (Engenharia de Software, Ciência de Dados, DevOps, UI/UX, etc.).
StatusOportunidade: Previsto, Inscrições Abertas, Inscrições Encerradas, Em Andamento, Processo Pausado, Processo Cancelado, Processo Concluído.
Construção e Execução de Dados de Teste (02_povoar_dados_teste.sql)
Criação do ecossistema transacional fictício para simulação de cenários reais:
Usuários: Inserção de 5 candidatos com e-mails únicos e hashes seguros de senha simulados.
Empresas e Oportunidades: Inserção de empresas (TechNova Solutions, DataCorp Analytics, CloudSys) e vagas vinculadas aos catálogos.

Tabelas Associativas (N:N): Vinculação de habilidades a usuários e vagas, fontes a vagas, e empresas a vagas.
Experiência e Histórico: População do histórico profissional de candidatos e fases do processo seletivo.

Teste Prático de Constraints e Regras de Integridade
Validação de Chave Composta em Inscricao: Testada e confirmada a rejeição/ignoração de registro duplicado para a combinação (usuario_id = 1, oportunidade_id = 1).

Validação de Senhas Seguras: Confirmação de suporte a armazenamento de hashes no formato $2y$10$....

Execução de Consultas de Validação (JOINs Avançados)
Verificação física no banco SQLite confirmando a integridade das referências:

Junção de Oportunidade com Modalidade, AreaEstudo, NivelConhecimento e StatusOportunidade.
Junção de Usuario com Inscricao e Oportunidade.
Junção de HistoricoStatus ordenado cronologicamente.
Mapeamento de vagas com múltiplas fontes (OportunidadeFonte) e empresas (EmpresaOportunidade).

Onde Paramos (Ponto de Retomada)
O banco de dados SQLite foi fisicamente compilado, totalmente populado com dados de teste e validado com sucesso através de consultas relacionais.

Próximos Passos Sugeridos
Definição da Stack de Backend: Escolher a linguagem/framework para construção da API REST (ex: Python + FastAPI ou Node.js + Express).

Definição da Camada de Acesso a Dados: Escolher entre SQL Puro / Query Builder (ex: Knex / asyncpg) ou ORM (ex: SQLAlchemy / Prisma / Drizzle).

Estratégia de Ingestão de Vagas: Planejar a arquitetura para coleta, parsing ou integração das oportunidades externas.


# 5. DECISÕES QUE NÃO DEVEM SER INVENTADAS

A próxima GEM não deve assumir automaticamente:

* framework;
* linguagem;
* banco de dados específico;
* arquitetura;
* API;
* estratégia de scraping;
* estratégia de busca;
* cardinalidades ainda não confirmadas;
* estrutura definitiva das tabelas;
* campos que ainda não foram decididos.

Quando necessário, deve perguntar ou apresentar alternativas.

---

# 6. COMO RETOMAR

Ao iniciar uma nova sessão:

1. identificar que o projeto ativo é o Tech Opportunities Hub;
2. ler este arquivo;
3. consultar o estado do projeto;
4. consultar as decisões;
5. verificar o que está confirmado;
6. identificar pendências;
7. continuar a partir da última etapa.

Não tratar sugestões antigas como decisões.

Não inventar informações ausentes.

---

# 7. PRINCÍPIO DE CONTINUIDADE

A nova GEM deve continuar o projeto como professora.

Ela não deve simplesmente responder:

> "Aqui está o banco pronto."

Deve conduzir o raciocínio de forma progressiva, permitindo que o estudante participe das decisões e compreenda os motivos técnicos.

Quando uma decisão já estiver confirmada, não deve ser alterada silenciosamente.

Quando encontrar uma alternativa melhor, deve apresentar:

* decisão atual;
* alternativa;
* vantagens;
* desvantagens;
* impacto;
* recomendação.

Depois, aguardar confirmação quando a mudança representar uma decisão de projeto.

TECH OPPORTUNITIES HUB — REGRAS DE NEGÓCIO E DECISÕES

1. PREVENÇÃO DE DUPLICAÇÃO E INTEGRIDADE NO BANCO DE DADOS

A integridade relacional do sistema é garantida diretamente no nível do banco de dados por meio de restrições de chaves compostas e restrições de unicidade:
Inscrição de Candidato: A tabela Inscricao utiliza chave primária composta (usuario_id, oportunidade_id), o que impede que um mesmo candidato se inscreva mais de uma vez na mesma oportunidade.   
Competências do Usuário: A tabela UsuarioHabilidade adota chave primária composta (usuario_id, habilidade_id) para evitar a duplicação do registro de uma mesma habilidade no perfil do candidato.   
Requisitos da Vaga: A tabela HabilidadeOportunidade aplica chave primária composta (oportunidade_id, habilidade_id) para impedir o cadastro redundante do mesmo requisito em uma vaga.   
Vincular Empresa a Oportunidade: A tabela EmpresaOportunidade possui chave primária composta (empresa_id, oportunidade_id), garantindo a associação entre empresa e vaga sem duplicidades.   
Múltiplas Origens de Vagas: A tabela OportunidadeFonte adota chave primária composta (oportunidade_id, fonte_id), permitindo mapear a presença de uma vaga em diferentes plataformas sem gerar registros repetidos.   
Unicidade de Contas: A tabela Usuario exige valor único na coluna email via restrição UNIQUE, impedindo a criação de mais de uma conta com o mesmo endereço de e-mail.   
Unicidade de Origem: A tabela Fonte aplica restrição UNIQUE na coluna endereco_url para evitar o cadastro duplicado de um mesmo domínio ou link de origem.   
Unicidade de Nível: A tabela NivelConhecimento restringe a coluna descricao com a cláusula UNIQUE para prevenir níveis repetidos no catálogo.   

2. DECISÕES TÉCNICAS CONFIRMADAS

Segurança no Armazenamento de Senhas: Nenhuma senha é gravada em texto puro. A coluna senha na tabela Usuario é dimensionada como varchar(255) para suportar o armazenamento seguro de hashes criptográficos gerados por algoritmos como Bcrypt ou Argon2.   
Conceito Unificado de Habilidade: A antiga nomenclatura "Tecnologia" foi definitivamente substituída pelo termo "Habilidade". A mesma entidade do catálogo atende simultaneamente aos requisitos declarados nas oportunidades (HabilidadeOportunidade) e às competências do currículo do candidato (UsuarioHabilidade).   
Rastreabilidade e Linha do Tempo (HistoricoStatus): O sistema não sobrescreve o status do candidato durante o processo seletivo. A tabela HistoricoStatus utiliza chave primária própria (id) e registra a marcação temporal (data_mudanca) de cada transição de fase, permitindo a auditoria completa da evolução do estudante na vaga.   
Histórico Profissional (ExperienciaUsuario): A trajetória profissional fica desacoplada do cadastro básico, permitindo a inclusão de múltiplos registros de experiências anteriores por candidato.   

3. DECISÕES PENDENTES (LÓGICA DE NEGÓCIO E BACKEND)

As seguintes definições arquiteturais e de negócio precisam ser estabelecidas na fase de construção das APIs:

Estratégia de Ingestão de Oportunidades: Definir se o fluxo de entrada das vagas ocorrerá via cadastro manual administrativo, consumo de APIs parceiras ou processos automatizados de web scraping.   
Divergência de Informações entre Fontes: Como a vaga pode apontar para múltiplas fontes, está pendente a definição da regra de interface para dados conflitantes: se o sistema deverá exibir priorizadamente a informação da fonte mais recente ou se instruirá o usuário a checar a fonte original.   
Requisitos Mínimos de Onboarding: Estabelecer quais campos do perfil do candidato e do histórico profissional serão de preenchimento obrigatório no momento da criação de conta.   
PRAGMA foreign_keys = ON;
insert or ignore into usuario (id, nome, email,senha, objetivo) values (1, 'João Silva', 'joao.silva@example.com', '$2y$10$simulacaoHashSeguroParaSenha123', 'Desenvolvedor Python');
insert or ignore into usuario (id, nome, email,senha, objetivo) values (2, 'Maria Oliveira', 'maria.oliveira@example.com', '$2y$10$simulacaoHashSeguroParaSenha123', 'Designer UI/UX');
insert or ignore into usuario (id, nome, email,senha, objetivo) values (3, 'Carlos Souza', 'carlos.souza@example.com', '$2y$10$simulacaoHashSeguroParaSenha123', 'Analista de Dados');
insert or ignore into usuario (id, nome, email,senha, objetivo) values (4, 'Ana Costa', 'ana.costa@example.com', '$2y$10$simulacaoHashSeguroParaSenha123', 'Engenheira de Software');
insert or ignore into usuario (id, nome, email,senha, objetivo) values (5, 'Pedro Lima', 'pedro.lima@example.com', '$2y$10$simulacaoHashSeguroParaSenha123', 'Desenvolvedor Mobile');

INSERT or ignore INTO Empresa (id, nome) VALUES (1, 'TechNova Solutions'), (2, 'DataCorp Analytics'), (3, 'CloudSys Web Services');

INSERT or ignore INTO Oportunidade (
    id, titulo, descricao, requisitos, data_final_inscricao, 
    modalidade_id, area_de_estudo_id, nivel_conhecimento_id, status_oportunidade_id, data_ultima_atualizacao
) VALUES 
(1, 'Desenvolvedor Backend Python', 'Atuação na construção de microsserviços e APIs REST.', 'Python, FastAPI, Docker, SQL', '2026-09-01 23:59:59', 1, 10, 2, 2, CURRENT_TIMESTAMP),

(2, 'Estágio em Análise de Dados', 'Auxiliar na limpeza e visualização de dados de marketing.', 'SQL básico, Excel, Python (Pandas)', '2026-08-30 23:59:59', 3, 6, 1, 2, CURRENT_TIMESTAMP),

(3, 'Engenheiro Cloud AWS Especialista', 'Liderar migração de infraestrutura legada para nuvem AWS.', 'AWS, Terraform, Kubernetes, CI/CD', '2026-09-15 23:59:59', 1, 12, 4, 2, CURRENT_TIMESTAMP);

INSERT or ignore INTO Inscricao (usuario_id, oportunidade_id) VALUES 
(1, 1), -- Ana Silva se inscreve na vaga Python
(2, 2), -- Carlos se inscreve na vaga de Dados
(1, 3), -- Ana Silva se inscreve na vaga Cloud
(1, 1); -- TENTATIVA DE DUPLICAÇÃO: Ana tenta se inscrever de novo em Python

INSERT OR IGNORE INTO UsuarioHabilidade (usuario_id, habilidade_id, nivelconhecimento_id) VALUES 
(1, 1, 3), -- Ana Silva (id 1) possui a Habilidade 1 no nível Avançado (3)
(1, 2, 2), -- Ana Silva (id 1) possui a Habilidade 2 no nível Intermediário (2)
(2, 2, 1); -- Carlos Eduardo (id 2) possui a Habilidade 2 no nível Básico (1)

INSERT OR IGNORE INTO HabilidadeOportunidade (oportunidade_id, habilidade_id) VALUES 
(1, 1), -- Oportunidade 1 exige a Habilidade 1
(1, 2), -- Oportunidade 1 exige a Habilidade 2
(2, 2); -- Oportunidade 2 exige a Habilidade 2

INSERT OR IGNORE INTO EmpresaOportunidade (empresa_id, oportunidade_id) VALUES 
(1, 1), -- TechNova Solutions oferece a vaga Backend Python
(2, 2), -- DataCorp Analytics oferece a vaga de Análise de Dados
(3, 3); -- CloudSys Web Services oferece a vaga Cloud AWS

INSERT OR IGNORE INTO OportunidadeFonte (oportunidade_id, fonte_id) VALUES 
(1, 1), -- Vaga Python foi encontrada na Fonte 1
(1, 2), -- Vaga Python TAMBÉM foi encontrada na Fonte 2
(2, 1); -- Vaga de Dados foi encontrada na Fonte 1

insert or ignore into HistoricoStatus (usuario_id, oportunidade_id, status, data_mudanca) values 
(1, 1, 'Inscrito', '2026-01-01 00:00:00'),
(1, 1, 'Em análise', '2026-01-05 00:00:00'),
(1, 1, 'Aprovado', '2026-01-10 00:00:00'),
(2, 2, 'Inscrito', '2026-01-02 00:00:00'),
(2, 2, 'Reprovado', '2026-01-06 00:00:00');

insert or ignore into ExperienciaUsuario (usuario_id, cargo, empresa_nome, data_inicio, data_fim, descricao) values 
(1, 'Desenvolvedor Junior', 'TechNova Solutions', '2024-01-01', '2025-01-01', 'Trabalhou no desenvolvimento de APIs e microsserviços.'),
(2, 'Analista de Dados', 'DataCorp Analytics', '2023-06-01', '2024-06-01', 'Responsável por análises de dados e criação de dashboards.'),
(3, 'Engenheiro de Software', 'CloudSys Web Services', '2022-03-01', NULL, 'Atua na arquitetura e desenvolvimento de soluções em nuvem.');


select * from Usuario;
select * from Empresa;  
select
    o.id,
    o.titulo,
    o.descricao,
    o.requisitos,
    o.data_final_inscricao,
    m.nome AS modalidade,
    ae.nome AS AreaEstudo,
    nc.descricao AS nivel_conhecimento,
    so.nome AS status_oportunidade,
    o.data_ultima_atualizacao
from Oportunidade o
left join Modalidade m on m.id = o.modalidade_id
left join AreaEstudo ae on ae.id = o.area_de_estudo_id
left join NivelConhecimento nc on nc.id = o.nivel_conhecimento_id
left join StatusOportunidade so on so.id = o.status_oportunidade_id;


select
    u.nome AS Usuario,
    o.titulo AS Oportunidade
from Inscricao i
join Usuario u on u.id = i.usuario_id
join Oportunidade o on o.id = i.oportunidade_id;

select 
    u.nome AS Usuario,
    h.nome AS Habilidade,
    nc.descricao AS NivelConhecimento
from UsuarioHabilidade uh
join Usuario u on u.id = uh.usuario_id
join Habilidade h on h.id = uh.habilidade_id
join NivelConhecimento nc on nc.id = uh.nivelconhecimento_id;

select
    h.nome AS Habilidade,
    o.titulo AS Oportunidade
from HabilidadeOportunidade ho
join Habilidade h on h.id = ho.habilidade_id
join Oportunidade o on o.id = ho.oportunidade_id;


SELECT 
    e.nome AS Empresa,
    o.titulo AS Oportunidade,
    f.endereco_url AS Fonte_Origem
FROM EmpresaOportunidade eo
JOIN Empresa e ON e.id = eo.empresa_id
JOIN Oportunidade o ON o.id = eo.oportunidade_id
JOIN OportunidadeFonte ofe ON ofe.oportunidade_id = o.id
JOIN Fonte f ON f.id = ofe.fonte_id;

SELECT 
    U.nome AS Usuario, 
    O.titulo AS Vaga_Inscrita
FROM Usuario U
JOIN Inscricao I ON I.usuario_id = U.id
JOIN Oportunidade O ON O.id = I.oportunidade_id
;

SELECT 
    u.nome AS Candidato,
    o.titulo AS Vaga,
    hs.status AS Status_Fase,
    hs.data_mudanca AS Data_Atualizacao
FROM HistoricoStatus hs
JOIN Usuario u ON u.id = hs.usuario_id
JOIN Oportunidade o ON o.id = hs.oportunidade_id
ORDER BY hs.data_mudanca ASC;
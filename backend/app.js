const express = require("express");
const db = require("./database");

const catalogosRoutes = require("./routes/catalogos");
const oportunidadesRoutes = require("./routes/oportunidades");

const app = express();

app.use(express.json());
app.use("/api", catalogosRoutes);
app.use("/api", oportunidadesRoutes);


const PORT = 3000;

app.get("/", (req, res) => {
  res.send("API do Tech Opportunities Hub funcionando!");
});

app.get("/api/status", (req, res) => {
  res.json({ status: "ok", message: "API do Tech Opportunities Hub funcionando!" });
});

app.get("/api/db-status", (req, res) => {
  const resultado = db
    .prepare("SELECT sqlite_version() AS versao")
    .get();

  res.json({
    status: "ok",
    banco: "SQLite",
    versao: resultado.versao
  });
});

app.post("/api/oportunidades", (req, res) => {
  const {
    titulo,
    descricao,
    requisitos,
    data_final_inscricao,
    modalidade_id,
    area_de_estudo_id,
    nivel_conhecimento_id,
    status_oportunidade_id
  } = req.body;

  if (!titulo) {
    return res.status(400).json({
      erro: "O campo titulo é obrigatório!"
    });
  }

  if (!descricao) {
    return res.status(400).json({
      erro: "O campo descricao é obrigatório!"
    });
  }

  if (!requisitos) {
    return res.status(400).json({
      erro: "O campo requisitos é obrigatório!"
    });
  }

  if (!data_final_inscricao) {
    return res.status(400).json({
      erro: "O campo data_final_inscricao é obrigatório!"
    });
  }

  if (!modalidade_id) {
    return res.status(400).json({
      erro: "O campo modalidade_id é obrigatório!"
    });
  }

  if (!area_de_estudo_id) {
    return res.status(400).json({
      erro: "O campo area_de_estudo_id é obrigatório!"
    });
  }

  if (!nivel_conhecimento_id) {
    return res.status(400).json({
      erro: "O campo nivel_conhecimento_id é obrigatório!"
    });
  }

  if (!status_oportunidade_id) {
    return res.status(400).json({
      erro: "O campo status_oportunidade_id é obrigatório!"
    });
}

try {

  const resultado = db.prepare(`
    INSERT INTO Oportunidade (
      titulo,
      descricao,
      requisitos,
      data_final_inscricao,
      modalidade_id,
      area_de_estudo_id,
      nivel_conhecimento_id,
      status_oportunidade_id,
      data_ultima_atualizacao
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
  `).run(
    titulo,
    descricao,
    requisitos,
    data_final_inscricao,
    modalidade_id,
    area_de_estudo_id,
    nivel_conhecimento_id,
    status_oportunidade_id
  );

  const novaOportunidadeId = resultado.lastInsertRowid;

  const novaOportunidade = db.prepare(`
  SELECT
    o.id,
    o.titulo,
    o.descricao,
    o.requisitos,
    o.data_final_inscricao,
    m.nome AS modalidade,
    ae.nome AS area_estudo,
    nc.descricao AS nivel_conhecimento,
    so.nome AS status_oportunidade,
    o.data_ultima_atualizacao
  FROM Oportunidade o
  LEFT JOIN Modalidade m
    ON m.id = o.modalidade_id
  LEFT JOIN AreaEstudo ae
    ON ae.id = o.area_de_estudo_id
  LEFT JOIN NivelConhecimento nc
    ON nc.id = o.nivel_conhecimento_id
  LEFT JOIN StatusOportunidade so
    ON so.id = o.status_oportunidade_id
  WHERE o.id = ?
`).get(novaOportunidadeId);

  res.status(201).json({
    mensagem: "Oportunidade criada com sucesso",
    oportunidade: novaOportunidade
  });

} catch (erro) {
  console.error(erro);
      
  if (erro.code === "SQLITE_CONSTRAINT_FOREIGNKEY") {
    return res.status(400).json({
      erro: "Um dos IDs informados não existe no banco de dados"
    });
  }

  return res.status(500).json({
    erro: "Erro interno do servidor"
  });
}
});

app.patch("/api/oportunidades/:id", (req, res) => {
  const id = req.params.id;

  const {
    titulo,
    descricao,
    requisitos,
    data_final_inscricao,
    modalidade_id,
    area_de_estudo_id,
    nivel_conhecimento_id,
    status_oportunidade_id
  } = req.body;

  const oportunidadeExistente = db
  .prepare("SELECT * FROM Oportunidade WHERE id = ?")
  .get(id);

  if (!oportunidadeExistente) {
    return res.status(404).json({
      erro: "Oportunidade não encontrada"
    });
  }

  if (titulo !== undefined && titulo.trim() === "") {
    return res.status(400).json({
      erro: "O campo titulo não pode estar vazio"
    });
  }

  if (descricao !== undefined && descricao.trim() === "") {
    return res.status(400).json({
      erro: "O campo descricao não pode estar vazio"
    });
  }

  if (requisitos !== undefined && requisitos.trim() === "") {
    return res.status(400).json({
      erro: "O campo requisitos não pode estar vazio"
    });
  }

  const novoTitulo = titulo ?? oportunidadeExistente.titulo;
  const novaDescricao = descricao ?? oportunidadeExistente.descricao;
  const novosRequisitos = requisitos ?? oportunidadeExistente.requisitos;
  const novaDataFinalInscricao = data_final_inscricao ?? oportunidadeExistente.data_final_inscricao;
  const novaModalidadeId = modalidade_id ?? oportunidadeExistente.modalidade_id;
  const novaAreaDeEstudoId = area_de_estudo_id ?? oportunidadeExistente.area_de_estudo_id;
  const novoNivelConhecimentoId = nivel_conhecimento_id ?? oportunidadeExistente.nivel_conhecimento_id;
  const novoStatusOportunidadeId = status_oportunidade_id ?? oportunidadeExistente.status_oportunidade_id;

  try {
  db.prepare(`
    UPDATE Oportunidade
    SET
      titulo = ?,
      descricao = ?,
      requisitos = ?,
      data_final_inscricao = ?,
      modalidade_id = ?,
      area_de_estudo_id = ?,
      nivel_conhecimento_id = ?,
      status_oportunidade_id = ?,
      data_ultima_atualizacao = CURRENT_TIMESTAMP
    WHERE id = ?
  `).run(
    novoTitulo,
    novaDescricao,
    novosRequisitos,
    novaDataFinalInscricao,
    novaModalidadeId,
    novaAreaDeEstudoId,
    novoNivelConhecimentoId,
    novoStatusOportunidadeId,
    id
  );
  const oportunidadeAtualizada = db.prepare(`
  SELECT
    o.id,
    o.titulo,
    o.descricao,
    o.requisitos,
    o.data_final_inscricao,
    m.nome AS modalidade,
    ae.nome AS area_estudo,
    nc.descricao AS nivel_conhecimento,
    so.nome AS status_oportunidade,
    o.data_ultima_atualizacao
  FROM Oportunidade o
  LEFT JOIN Modalidade m
    ON m.id = o.modalidade_id
  LEFT JOIN AreaEstudo ae
    ON ae.id = o.area_de_estudo_id
  LEFT JOIN NivelConhecimento nc
    ON nc.id = o.nivel_conhecimento_id
  LEFT JOIN StatusOportunidade so
    ON so.id = o.status_oportunidade_id
  WHERE o.id = ?
`).get(id);

return res.status(200).json({
  mensagem: "Oportunidade atualizada com sucesso",
  oportunidade: oportunidadeAtualizada
});

} catch (erro) {
  console.error(erro);

  if (erro.code === "SQLITE_CONSTRAINT_FOREIGNKEY") {
    return res.status(400).json({
      erro: "Um dos IDs informados não existe no banco de dados"
    });
  }

  return res.status(500).json({
    erro: "Erro interno do servidor"
  });
}
});

app.delete("/api/oportunidades/:id", (req, res) => {
  const id = req.params.id;

  const oportunidadeExistente = db
    .prepare("SELECT id FROM Oportunidade WHERE id = ?")
    .get(id);

  if (!oportunidadeExistente) {
    return res.status(404).json({
      erro: "Oportunidade não encontrada"
    });
  }

  try {
    db.prepare("DELETE FROM Oportunidade WHERE id = ?").run(id);

    return res.status(200).json({
      mensagem: "Oportunidade excluída com sucesso"
    });

} catch (erro) {
  console.error(erro);

  if (erro.code === "SQLITE_CONSTRAINT_FOREIGNKEY") {
    return res.status(409).json({
      erro: "A oportunidade não pode ser excluída porque possui dados relacionados"
    });
  }

  return res.status(500).json({
    erro: "Erro interno do servidor"
  });
}
});

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
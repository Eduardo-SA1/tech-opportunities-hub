const express = require("express");
const router = express.Router();
const db = require("../database");

router.get("/oportunidades", (req, res) => {
  const oportunidades = db.prepare(`
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
  `).all();

  res.json(oportunidades);
});

router.get("/oportunidades/:id", (req, res) => {
  const id = req.params.id;

  const oportunidade = db.prepare(`
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

    if (!oportunidade) {
    return res.status(404).json({
      erro: "Oportunidade não encontrada"
    });
  }

  res.json(oportunidade);
});

module.exports = router;
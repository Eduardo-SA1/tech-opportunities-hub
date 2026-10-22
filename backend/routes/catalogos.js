const express = require("express");
const router = express.Router();
const db = require("../database");

router.get("/niveis", (req, res) => {
  const niveis = db
    .prepare("SELECT * FROM NivelConhecimento")
    .all();

  res.json(niveis);
});

router.get("/modalidades", (req, res) => {
  const modalidades = db
    .prepare("SELECT * FROM Modalidade")
    .all(); 

  res.json(modalidades);
});

router.get("/areas", (req, res) => {
  const areas = db
    .prepare("SELECT * FROM AreaEstudo")
    .all();

  res.json(areas);
});

router.get("/status-oportunidades", (req, res) => {
  const statusOportunidades = db
    .prepare("SELECT * FROM StatusOportunidade")
    .all();

  res.json(statusOportunidades);
});

module.exports = router;
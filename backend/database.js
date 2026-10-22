const Database = require("better-sqlite3");
const path = require("path");

const dbPath = path.join(__dirname, "..", "tech_hub.db");

const db = new Database(dbPath, {
  fileMustExist: true
});

db.pragma("foreign_keys = ON");

console.log("Banco de dados conectado com sucesso!");

module.exports = db;
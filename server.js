const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const usersRoutes = require("./routes/user");

app.use(bodyParser.json());

app.use("/users", usersRoutes);

app.get("/", (req, res) => {
  res.status(200).json({ ping: "pong (atualizado)" });
});

module.exports = app;

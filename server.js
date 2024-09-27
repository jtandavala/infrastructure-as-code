// app.js

const express = require("express");
const app = express();

// Define a route for the root URL ("/")
app.get("/", (req, res) => {
  res.send("Hello World! atualizado");
});

// Start the server and listen on port 3000
const port = 3000;
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

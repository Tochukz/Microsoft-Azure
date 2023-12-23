require("dotenv").config();
const http = require("http");
const express = require("express");
var indexRouter = require("./router");

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use("/", indexRouter);

app.use(function (err, req, res, next) {
  res.status(err.status || 500);
  res.json({ error: err?.toString() });
});

const server = http.createServer(app);

const port = process.env.PORT ?? 8089;
server.listen(port, () => console.log(`Server running on localhost:${port}`));

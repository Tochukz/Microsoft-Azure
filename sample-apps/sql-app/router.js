const express = require("express");

const router = express.Router();

const partitionKey = "pizzamenu";

router.get("/", (req, res, next) => {
  return res.json({ message: "Welcome to SQL Database App" });
});

module.exports = router;

var express = require("express");
var router = express.Router();

/* GET home page. */
router.get("/", function (req, res, next) {
  res.render("index", { title: "Express" });
});

router.get("/known-error", function (req, res, next) {
  throw new Error("Express error simulaton");
});

module.exports = router;

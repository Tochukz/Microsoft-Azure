var express = require("express");
var router = express.Router();
// const uuid = require("uuid"); // missing module

/* GET users listing. */
router.get("/", function (req, res, next) {
  res.send("respond with a resource");
});

module.exports = router;

const express = require("express");
const { v4: uuidv4 } = require("uuid");
const { odata } = require("@azure/data-tables");
const { getTableClient } = require("./helper");

const router = express.Router();

const partitionKey = "pizzamenu";

router.get("/", (req, res, next) => {
  return res.json({ message: "Welcome to Simple Table API" });
});

router.get("/pizza-list", async (req, res, next) => {
  try {
    const tableClient = getTableClient();
    const entities = await tableClient.listEntities({
      queryOptions: { filter: odata`PartitionKey eq ${partitionKey}` },
    });

    return res.json(entities);
  } catch (error) {
    return next(error);
  }
});

router.get("/pizza/:rowKey", async (req, res, next) => {
  try {
    const rowKey = req.params("rowKey");
    const tableClient = getTableClient();
    const entity = await tableClient.getEntity("pizzamenu", rowKey);
    return res.json(entity);
  } catch (error) {
    return next(error);
  }
});

router.post("/create-pizza", async (req, res, next) => {
  const { description, cost } = req.body;
  if (!description || !cost) {
    const errMsg = "description and cost are required";
    const error = new Error(errMsg);
    error.status = 400;
    return next(error);
  }
  const entity = {
    partitionKey,
    rowKey: uuidv4(),
    description,
    cost,
    createdAt: new Date(),
  };

  // return res.json(entity);

  console.log("entity", entity);

  try {
    const tableClient = getTableClient();
    const result = await tableClient.createEntity(entity);
    return res.json(result);
  } catch (error) {
    return next(error);
  }
});

router.post("/update-pizza", async (req, res, next) => {
  const { description, cost, rowKey } = req.body;
  const newRowKey = uuidv4();
  const entity = {
    partitionKey,
    rowKey: rowKey ?? newRowKey,
    description,
    cost,
    createdAt: new Date(),
  };

  try {
    const tableClient = getTableClient();
    const result = await tableClient.upsertEntity(entity);
    return req.json(result);
  } catch (error) {
    return next(error);
  }
});

router.post("/create-many-pizza", async (req, res, next) => {
  const { pizzas } = req.body;
  if (!Array.isArray(pizzas)) {
    const errMsg = "pizzas must be an array of Pizza objects";
    next(new Error(errMsg));
  }
  const entities = pizzas.map((pizza) => {
    const { description, cost } = pizza;
    const entity = {
      partitionKey,
      rowKey: uuidv4(),
      description,
      cost,
      createdAt: new Date(),
    };
    return ["create", entity];
  });
  try {
    const tableClient = getTableClient();
    const result = await tableClient.submitTransaction(entities);
    return res.json(result);
  } catch (error) {
    return next(error);
  }
});

module.exports = router;

const express = require("express");
const { v4: uuidv4 } = require("uuid");
const { getQueueClient, jsonToBase64, base64ToJson } = require("./helper");

const router = express.Router();

router.get("/", (req, res, next) => {
  return res.json({ message: "Welcome to Simple Queue API" });
});

router.post("/encode-message", async (req, res, next) => {
  const { description, cost } = req.body;
  if (!description || !cost) {
    const errMsg = "description and cost are required";
    const error = new Error(errMsg);
    error.status = 400;
    return next(error);
  }
  const base64Message = jsonToBase64({ description, cost });
  return res.json({ message: { description, cost }, base64: base64Message });
});

router.post("/decode-message", async (req, res, next) => {
  const { base64 } = req.body;
  if (!base64) {
    const errMsg = "base64 is required";
    const error = new Error(errMsg);
    error.status = 400;
    return next(error);
  }
  const json = base64ToJson(base64);
  return res.json({ base64, message: json });
});

router.get("/message-list", async (req, res, next) => {
  try {
    const queueClient = getQueueClient();
    const properties = await queueClient.getProperties();
    const count = properties.approximateMessagesCount;
    const response = await queueClient.peekMessages({
      numberOfMessages: count,
    });
    let result = { allMessageItems: [] };
    if (response._response?.status == 200) {
      const { date, version, peekedMessageItems } = response;
      result = { date, version, count, allMessageItems: peekedMessageItems };
    }
    result.allMessageItems.forEach((message) => {
      message.messageJson = base64ToJson(message.messageText);
    });
    return res.json(result);
  } catch (error) {
    return next(error);
  }
});

router.post("/add-message", async (req, res, next) => {
  const { description, cost } = req.body;
  if (!description || !cost) {
    const errMsg = "description and cost are required";
    const error = new Error(errMsg);
    error.status = 400;
    return next(error);
  }
  try {
    const base64Message = jsonToBase64({ description, cost });
    const queueClient = getQueueClient();
    const response = await queueClient.sendMessage(base64Message);
    let result = {};
    if (response._response?.status == 201) {
      const { date, requestId, messageId, expiresOn, insertedOn } = response;
      result = { date, requestId, messageId, expiresOn, insertedOn };
    }
    return res.json(result);
  } catch (error) {
    return next(error);
  }
});

router.get("/pick-messages", async (req, res, next) => {
  const queryCount = req.query.count;
  const count = queryCount ? parseInt(queryCount) : 2;
  try {
    const queueClient = getQueueClient();
    const response = await queueClient.peekMessages({
      numberOfMessages: count,
    });
    let result = { peekedMessageItems: [] };
    if (response._response?.status == 200) {
      const { date, version, peekedMessageItems } = response;
      result = { date, version, peekedMessageItems };
    }
    result.peekedMessageItems.forEach((message) => {
      message.messageJson = base64ToJson(message.messageText);
    });
    return res.json(result);
  } catch (error) {
    return next(error);
  }
});

router.get("/receive-messages", async (req, res, next) => {
  try {
    const queueClient = getQueueClient();
    const queryCount = req.query.count;
    const count = queryCount ? parseInt(queryCount) : 1;
    const response = await queueClient.receiveMessages({
      numberOfMessages: count,
    });

    let result = { receivedMessageItems: [] };
    if (response._response?.status == 200) {
      const { date, version, receivedMessageItems } = response;
      result = { date, version, receivedMessageItems };
    }
    result.receivedMessageItems.forEach((message) => {
      message.messageJson = base64ToJson(message.messageText);
    });
    return res.json(result);
  } catch (error) {
    return next(error);
  }
});

router.delete("/delete-message", async (req, res, next) => {
  const { popReceipt, messageId } = req.body;
  if (!messageId || !popReceipt) {
    const errMsg = "popReceipt and messageId are required";
    const error = new Error(errMsg);
    error.status = 400;
    return next(error);
  }
  try {
    const queueClient = getQueueClient();
    const response = await queueClient.deleteMessage(messageId, popReceipt);
    return res.json(response);
  } catch (error) {
    return next(error);
  }
});
module.exports = router;

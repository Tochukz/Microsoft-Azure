const { QueueClient } = require("@azure/storage-queue");
const {
  DefaultAzureCredential,
  AzureCliCredential,
} = require("@azure/identity");
const { v1: uuidv1 } = require("uuid");

function jsonToBase64(json) {
  const jsonString = JSON.stringify(json);
  return Buffer.from(jsonString).toString("base64");
}

function base64ToJson(base64String) {
  const jsonString = Buffer.from(base64String, "base64").toString();
  return JSON.parse(jsonString);
}

function getQueueClient() {
  const { QUEUE_ID } = process.env;
  const azureCredential = new DefaultAzureCredential();
  //const azureCredential = new AzureCliCredential();
  const queueClient = new QueueClient(QUEUE_ID, azureCredential);
  return queueClient;
}

async function createQueue() {
  // Create a new queue
  const queueClient = getQueueClient();
  const createQueueResponse = await queueClient.create();
  return createQueueResponse;
}

module.exports = {
  jsonToBase64,
  base64ToJson,
  getQueueClient,
};

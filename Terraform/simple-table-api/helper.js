const {
  TableServiceClient,
  TableClient,
  AzureNamedKeyCredential,
  odata,
} = require("@azure/data-tables");

function getTableClient() {
  const { AZURE_ACCOUNT, AZURE_ACCESS_KEY } = process.env;
  const credential = new AzureNamedKeyCredential(
    AZURE_ACCOUNT,
    AZURE_ACCESS_KEY
  );
  const tableService = new TableServiceClient(
    AZURE_TABLES_ENDPOINT,
    credential
  );
  const tableClient = new TableClient(endpoint, "<table-name>", credential);
  return tableClient;
}

module.exports = {
  getTableClient,
};

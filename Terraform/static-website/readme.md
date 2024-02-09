# Static Website

### Description

This configuration deploys a static website resource.

### Setup

This instruction describes how to setup your project for Azure static webApp

1. Add the static WebApp CLI to your SPA project

```bash
$ cd react-app
$  npm install -D @azure/static-web-apps-cli
```

2. Run swa init

```bash
$ npx swa init
```

Follow the prompt.
This willm generate a `swa-cli.config.json` file based of SPA framework.

3. Access you StaticWebApp deployment token.

```bash
$ terraform output api_key
```

You can also access your deployment token using azure CLI

```bash
$ az staticwebapp secrets list --name <static-web-app-name> --query "properties.apiKey"
```

4. Deploy you SPA code

```bash

$ cd react-app
$ npm run build
$ export token=<deployment-token>
$ npx swa deploy ./build --deployment-token $token
```

### Learn more

[Build configuration for Azure Static Web Apps](https://learn.microsoft.com/en-us/azure/static-web-apps/build-configuration?tabs=github-actions)

### Tools

[Static Web Apps CLI](https://azure.github.io/static-web-apps-cli/)

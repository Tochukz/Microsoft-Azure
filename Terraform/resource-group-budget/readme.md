# Resource group budget

### Description

This configuration deploys a Resource group bugdet that monitors consumption for the specified resource group and sends email notifcation when the threshold is exceeded.

### Pre Deployment

**Setting environment variables**  
Before you deploy the configuration, you must setup environment variables for you contact emails so that terraform can pick them up and use them for variables.

First, copy the _sample-env.sh_ script and make it executable

```bash
$ cp sample-env.sh env.sh
$ chmod +x env.sh
```

Next, replace all the placeholder contact emails in _env.sh_ by your own emails.
Then you execute the script to set the environment variables

```bash
$ . ./env.sh
```

Now you are ready for deployment

**Not setting environment variables**  
Alternatively, you can supply the required variable at prompt during the deployment. Just run `terraform apply` and follow the prompt.

```bash
$ terraform apply
```

### Deployment

```bash
$ terraform apply
```

# Subscription Budget

### Description

This configuration deploys a Subscription budget that monitors consumption cost for your entire Azure subscription and then sends email and SMS notifications when the threshold is exceeded.

### Pre Deployment

**Setting environment variables**  
Before you deploy the configuration, you must setup environment variables for you emails and phone number so that terraform can pick them up to be used for variables.

First, copy the _sample-env.sh_ script and make it executable

```bash
$ cp sample-env.sh env.sh
$ chmod +x env.sh
```

Next, replace all the placeholder email and phone number in _env.sh_ by your own emails and phone number.
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

### Resources

[Countries/Regions with SMS notification support](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups#countriesregions-with-sms-notification-support)

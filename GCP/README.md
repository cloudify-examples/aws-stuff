# Cloudify Manager GCP Deployment Manager Template

Install a Cloudify Manager in GCP with a configuration file.

Bootstrap with the default configuration will take around 11 minutes (subject to GCP performance.)


## Instructions

For pre-setup follow [these](https://cloud.google.com/deployment-manager/docs/quickstart) instructions.

1. To deploy execute:

```shell
gcloud deployment-manager deployments create --config cloudify_manager.yaml cloudify
```

2. Go to the Deployment Manager in your Console. The URL should resemble: "https://console.cloud.google.com/deployments/details/cloudify?project=your-project".

3. Click on the "cloudify-manager" resource.

4. Click on "Manage Resource".

5. You can watch the deployment output under "Serial port 1 (console)".

6. When the deployment is finished, you will see "". Back on the "VM instance details" page, scroll to "Network interfaces". Copy the "External IP". Follow this IP in your browser.


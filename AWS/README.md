# Cloudify Manager AWS CloudFormation Template

Install a Cloudify Manager in AWS with CloudFormation.

## Installation

1. Open your AWS Account Console. Select CloudFormation from the list of services.

2. Select "Create Stack".

3. On the "Select Template" page, click the "Upload a template to Amazon S3" button. When you choose file, upload the "CloudifyEnvironmentSetup.json" file.

4. On the "Specify Details" page, give the Stack a name, like "Cloudify" and input your "AwsAccessKeyId" and "AwsSecretAccessKey". If you do not want to provide these values, you can do that later inside of your manager.

5. Click "Next", "Next", and then "Create".

The execution brings up the infrastructure in the manager. You will see "CREATE_COMPLETE" in the Stack status when everything is up.

Under "Resources", find the "CfyManagerEIP" Logical ID, and take the Physical ID. Open that URL in your browser. Login with the default username/password, Admin/Admin.

Upon startup, several script are running on the Mananger VM to further configure it. You will know that it is ready when you see 12 Secrets and 11 Plugins on the System Resources page.

On the Deployments page, you will see the agent_key deployment. One Node should be green.

Your Cloudify Manager VM is now ready to run examples. Try "nodecellar-auto-scale-auto-heal-blueprint" from the Blueprints catalog page.

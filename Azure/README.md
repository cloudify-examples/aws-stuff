# Cloudify Manager Azure ARM Template

Install a Cloudify Manager in Azure with a Template Deployment.

## Installation

1. Open [portal.azure.com](https://portal.azure.com) in your browser.

2. Click "+ New".

3. Under "Search the Marketplace", search for "Template Deployment" and select.

4. Click "Create".

5. Click "Build your own template in the editor".

6. Click "Load File" and upload the file "AzureResourceManagerTemplate.json".

7. Click "Save".

8. On the next page, under "Basics", you will need to select your subscription, resource group and location.

9. Under "Settings", you will need to fill the "ClientID" and "ClientSecret". If you do not already have these values, see [Creating a Service Principal](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/resource-group-create-service-principal-portal).

10. Select "I agree blah blah blah...", if you indeed agree.

11. Click "Purchase".

The deployment will take about 31 minutes. When you see the deployment has succeeded, the Cloudify Manager VM will now be ready to run examples. Go to the CfyVM Resource and copy its Public IP Address. Try "nodecellar-auto-scale-auto-heal-blueprint" from the Blueprints catalog page.

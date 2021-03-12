# Azure Machine Learning

## Disable network policies for private endpoints

```bash
az network vnet subnet update --name default --resource-group myResourceGroup --vnet-name myVirtualNetwork --disable-private-endpoint-network-policies true
```

## Add a private endpoint to a workspace

```bash
az ml workspace private-endpoint add --resource-group myWSResourceGroup --workspace-name myWorkspace --pe-name myPrivateEndpoint --pe-vnet-name myVirtualNetwork --pe-subnet-name mySubnet --pe-resource-group myVNResourceGroup
```

## Internal AKS load balancer

```bash
az ml computetarget update aks --name myInferenceCluster --load-balancer-subnet mySubnet --load-balancer-type InternalLoadBalancer --workspace myWorkspace --resource-group myResourceGroup
```

Most users are able to resolve issues concerning consuming endpoints by using the following steps.

**Recommended Steps**

1. See [Consume an Azure Machine Learning model deployed as a web service](https://docs.microsoft.com/azure/machine-learning/how-to-consume-web-service?WT.mc_id=Portal-Microsoft_Azure_Support). Deploying an Azure Machine Learning model as a web service creates a REST API endpoint. You can send data to this endpoint and receive the prediction returned by the model. The linked article will show you how to create clients for the web service by using C#, Go, Java, and Python.
2. See [Consume the service from Power BI](https://docs.microsoft.com/azure/machine-learning/how-to-consume-web-service?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#consume-the-service-from-power-bi). After the web service is deployed, it&#39;s consumable from Power BI dataflows. [Learn how to consume an Azure Machine Learning web service from Power BI](https://docs.microsoft.com/power-bi/transform-model/dataflows/dataflows-machine-learning-integration?WT.mc_id=Portal-Microsoft_Azure_Support).
3. [How to update a deployed web service](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-update-web-service?WT.mc_id=Portal-Microsoft_Azure_Support)
4. See [Advance Entry Script Authoring](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-advanced-entry-script?WT.mc_id=Portal-Microsoft_Azure_Support). This article shows how to write entry scripts for specialized use cases:
  - [Automatically generate a Swagger schema](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-advanced-entry-script?WT.mc_id=Portal-Microsoft_Azure_Support#automatically-generate-a-swagger-schema)
  - [Power BI Compatible endpoint](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-advanced-entry-script?WT.mc_id=Portal-Microsoft_Azure_Support#power-bi-compatible-endpoint)
  - [Binary (image) data](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-advanced-entry-script?WT.mc_id=Portal-Microsoft_Azure_Support#binary-data)
  - [Cross-origin resource sharing (CORS)](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-advanced-entry-script?WT.mc_id=Portal-Microsoft_Azure_Support#cross-origin-resource-sharing-cors)
  - [Load Registered models](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-advanced-entry-script?WT.mc_id=Portal-Microsoft_Azure_Support#load-registered-models). There are two ways to locate models in your entry script.
  - [Framework specific examples](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-advanced-entry-script?WT.mc_id=Portal-Microsoft_Azure_Support#framework-specific-examples). More entry script examples for specific machine learning use cases (PyTorch, TensorFlow, Keras, AutoML, ONNX).
5. The [InferenceSchema](https://github.com/Azure/InferenceSchema) Python package provides uniform schema for common machine learning applications, as well as a set of decorators that can be used to aid in web-based ML prediction applications.
6. [Troubleshoot a failed deployment](https://docs.microsoft.com/azure/machine-learning/how-to-troubleshoot-deployment?WT.mc_id=Portal-Microsoft_Azure_Support)
  - [Debug Locally](https://docs.microsoft.com/azure/machine-learning/how-to-troubleshoot-deployment?WT.mc_id=Portal-Microsoft_Azure_Support#debug-locally)
  - [HTTP status code 502](https://docs.microsoft.com/azure/machine-learning/how-to-troubleshoot-deployment?WT.mc_id=Portal-Microsoft_Azure_Support#http-status-code-502)
  - [HTTP status code 503](https://docs.microsoft.com/azure/machine-learning/how-to-troubleshoot-deployment?WT.mc_id=Portal-Microsoft_Azure_Support#http-status-code-503)
  - [HTTP status code 504](https://docs.microsoft.com/azure/machine-learning/how-to-troubleshoot-deployment?WT.mc_id=Portal-Microsoft_Azure_Support#http-status-code-504)
  - [Container cannot be scheduled error](https://docs.microsoft.com/azure/machine-learning/how-to-troubleshoot-deployment?WT.mc_id=Portal-Microsoft_Azure_Support#container-cannot-be-scheduled). When deploying a service to an Azure Kubernetes Service compute target, Azure Machine Learning will attempt to schedule the service with the requested amount of resources. If there are no nodes available in the cluster with appropriate amount of resources after 5 minutes, the deployment will fail.
  - [Service launch fails](https://docs.microsoft.com/azure/machine-learning/how-to-troubleshoot-deployment?WT.mc_id=Portal-Microsoft_Azure_Support#service-launch-fails). As part of container starting-up process, the init() function in your scoring script is invoked by the system. If there are uncaught error exceptions in the init() function, you might see CrashLoopBackOff error in the error message.
  - [Function fails: get\_model\_path()](https://docs.microsoft.com/azure/machine-learning/how-to-troubleshoot-deployment?WT.mc_id=Portal-Microsoft_Azure_Support#function-fails-get_model_path). Often, in the init() function in the scoring script, [Model.get\_model\_path()](https://docs.microsoft.com/python/api/azureml-core/azureml.core.model.model?view=azure-ml-py&amp;preserve-view=true&amp;WT.mc_id=Portal-Microsoft_Azure_Support#&amp;preserve-view=trueget-model-path-model-name--version-none---workspace-none-) function is called to locate a model file or folder of model files in the container. If the model file or folder cannot be found, the function fails.
  - [Function fails: run(input\_data)](https://docs.microsoft.com/azure/machine-learning/how-to-troubleshoot-deployment?WT.mc_id=Portal-Microsoft_Azure_Support#function-fails-runinput_data). If service is successfully deployed, but it crashes when you post data to the scoring endpoint, you can add error catching statement in your run(input\_data).
  - [Advance Debugging](https://docs.microsoft.com/azure/machine-learning/how-to-debug-visual-studio-code?WT.mc_id=Portal-Microsoft_Azure_Support#debug-and-troubleshoot-deployments). You may need to interactively debug the Python code contained in your model deployment. By using Visual Studio Code and the debugpy, you can attach to the code running inside Docker container.
  - [Webservices in Azure Kubernetes Service Failures](https://docs.microsoft.com/azure/machine-learning/resource-known-issues?WT.mc_id=Portal-Microsoft_Azure_Support#webservices-in-azure-kubernetes-service-failures). Many webservice failures in Azure Kubernetes Service can be debugged by connecting to the cluster using kubectl.
7. [Collect and evaluate model data](https://docs.microsoft.com/azure/machine-learning/how-to-enable-data-collection?WT.mc_id=Portal-Microsoft_Azure_Support)
8. [Monitor and collect data from ML web service endpoints](https://docs.microsoft.com/azure/machine-learning/how-to-enable-app-insights?WT.mc_id=Portal-Microsoft_Azure_Support)
9. [Limitations when deploying model to Azure Container Instances](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-azure-container-instance?WT.mc_id=Portal-Microsoft_Azure_Support#limitations).
10. [Secure an Azure Machine Learning Inferencing environment with virtual networks](https://docs.microsoft.com/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support)
  - [Learn about network requirements that must be met to use an AKS cluster in a virtual network](https://docs.microsoft.com/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#azure-kubernetes-service)
  - [Network Contributor Role](https://docs.microsoft.com/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#network-contributor-role)
  - [Secure VNet Traffic](https://docs.microsoft.com/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#secure-vnet-traffic). There are two ways to isolate traffic to and from AKS cluster to the virtual network. [Private AKS cluster](https://docs.microsoft.com/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#private-aks-cluster) and [Internal AKS Load Balancer](https://docs.microsoft.com/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#internal-aks-load-balancer)
  - [To enable Azure Machine Learning to create ACI inside the virtual network, you must enable subnet delegation for the subnet used by the deployment](https://docs.microsoft.com/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#enable-azure-container-instances-aci)
  - [Limit outbound connectivity from the virtual network](https://docs.microsoft.com/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#limit-outbound-connectivity-from-the-virtual-network)
  - [Understand connectivity requirements for AKS inferencing cluster](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-azure-kubernetes-service?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#understand-connectivity-requirements-for-aks-inferencing-cluster)

**Recommended Documents**

- [Deploy models with Azure Machine Learning](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-and-where?WT.mc_id=Portal-Microsoft_Azure_Support)
- [Deploy model to an Azure Kubernetes Service cluster](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-azure-kubernetes-service?WT.mc_id=Portal-Microsoft_Azure_Support)
- [Deploy a model to Azure Container Instances](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-azure-container-instance?WT.mc_id=Portal-Microsoft_Azure_Support)
- [AKS Autoscaling in Azure Machine Learning](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-azure-kubernetes-service?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#autoscaling) and [Azure ML Router](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-azure-kubernetes-service?tabs=python&amp;WT.mc_id=Portal-Microsoft_Azure_Support#azure-ml-router).

**Python SDK**

- [Webservice Package](https://docs.microsoft.com/python/api/azureml-core/azureml.core.webservice?view=azure-ml-py&amp;WT.mc_id=Portal-Microsoft_Azure_Support) contains functionality for deploying machine learning models as web service endpoints in Azure Machine Learning
- [AksWebService class](https://docs.microsoft.com/python/api/azureml-core/azureml.core.webservice.akswebservice?view=azure-ml-py&amp;preserve-view=true&amp;WT.mc_id=Portal-Microsoft_Azure_Support)
- [AciWebService class](https://docs.microsoft.com/python/api/azureml-core/azureml.core.webservice.aciwebservice?view=azure-ml-py&amp;WT.mc_id=Portal-Microsoft_Azure_Support)
- [SSL configuration class](https://docs.microsoft.com/python/api/azureml-core/azureml.core.compute.aks.sslconfiguration?view=azure-ml-py&amp;WT.mc_id=Portal-Microsoft_Azure_Support)
- [AksProvisioningConfiguration.enable\_ssl()](https://docs.microsoft.com/python/api/azureml-core/azureml.core.compute.aks.aksprovisioningconfiguration?view=azure-ml-py&amp;WT.mc_id=Portal-Microsoft_Azure_Support#enable-ssl-ssl-cname-none--ssl-cert-pem-file-none--ssl-key-pem-file-none--leaf-domain-label-none--overwrite-existing-domain-false-)
- [AksAttachConfiguration.enable\_ssl()](https://docs.microsoft.com/python/api/azureml-core/azureml.core.compute.aks.aksattachconfiguration?view=azure-ml-py&amp;WT.mc_id=Portal-Microsoft_Azure_Support#enable-ssl-ssl-cname-none--ssl-cert-pem-file-none--ssl-key-pem-file-none--leaf-domain-label-none--overwrite-existing-domain-false-)

**Enterprise Readiness and Security**

- [Use TLS to secure a web service through Azure Machine Learning](https://docs.microsoft.com/azure/machine-learning/how-to-secure-web-service?WT.mc_id=Portal-Microsoft_Azure_Support)
- [How to use your workspace with a custom DNS server](https://docs.microsoft.com/azure/machine-learning/how-to-custom-dns?tabs=azure-cli&amp;WT.mc_id=Portal-Microsoft_Azure_Support)
- [Secure the Inferencing environment](https://docs.microsoft.com/azure/machine-learning/how-to-network-security-overview?WT.mc_id=Portal-Microsoft_Azure_Support#secure-the-inferencing-environment)
- [Network isolation with private virtual networks](https://docs.microsoft.com/azure/machine-learning/how-to-enable-virtual-network?WT.mc_id=Portal-Microsoft_Azure_Support#azure-kubernetes-service)
- [Use Azure AD identity with your machine learning web service in Azure Kubernetes Service](https://docs.microsoft.com/azure/machine-learning/how-to-use-azure-ad-identity?WT.mc_id=Portal-Microsoft_Azure_Support)
- [Set up Web-service authentication](https://docs.microsoft.com/azure/machine-learning/how-to-setup-authentication?WT.mc_id=Portal-Microsoft_Azure_Support#web-service-authentication)
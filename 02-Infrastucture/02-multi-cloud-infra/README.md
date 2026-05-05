# 📦 CloudChaps Stores – AWS Infrastructure

## 📖 Overview 
This project defines a **modular, multi-environment Azure and GCP infrastructure** using **Terraform**.

## 🚀 Deployment Steps
### 1. Prerequisites
- Login using az login command

### 2. Deploy Azure Networking
```BASH
cd 02-Infrastucture/02-multi-cloud-infra/Live/Azure
terraform init -backend-config=../../Backend-config/azure-dev.backend.hcl
```
Then Plan:
```BASH
terraform plan -var-file=../../Environments/dev/azure.tfvars
```
Finally Plan:
```BASH
terraform apply -var-file=../../Environments/dev/azure.tfvars
```
### 3. Deploy Azure Authenticate github actions
```BASH
az ad sp create-for-rbac \
  --name "terraform-sp" \
  --role Contributor \
  --scopes /subscriptions/<SUBSCRIPTION_ID>
```
Expected Output:
```JSON
{
  "appId": "xxxx-xxxx-xxxx",
  "displayName": "terraform-sp",
  "password": "xxxx-xxxx-xxxx",
  "tenant": "xxxx-xxxx-xxxx"
}
```
🔁 Map to GitHub Secrets:
```BASH
appId      → AZURE_CLIENT_ID
password   → AZURE_CLIENT_SECRET
tenant     → AZURE_TENANT_ID
```

### 4. Deploy Compute Layer
```BASH
ALB → Target Groups → EC2
```
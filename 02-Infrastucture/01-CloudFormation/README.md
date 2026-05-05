# 📦 CloudChaps Stores – AWS Infrastructure

## 📖 Overview 

This project defines a **modular, multi-environment AWS infrastructure** using **CloudFormation**.

## 🚀 Deployment Steps
### 1. Prerequisites
- AWS CLI configured
- IAM Role with:
    - CloudFormation access
    - EC2 permissions
    - iam:PassRole (if needed)
### 2. Deploy Networking
```BASH
cd 02-Infrastucture/01-Cloudformation/scripts
./scripts/deploy-vpc-dev.sh <profile> <account-id> <role-name>
```
Then Deploy:
```BASH
subnets → route tables → NAT → security groups
```
### 3. Deploy Database Layer
```BASH
db-subnet-group → RDS
```
### 4. Deploy Compute Layer
```BASH
ALB → Target Groups → EC2
```
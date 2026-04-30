#!/bin/bash

set -e

PROFILE_NAME=$1
ACCOUNT_ID=$2
ROLE_NAME=$3

if [ -z "$PROFILE_NAME" ] || [ -z "$ACCOUNT_ID" ] || [ -z "$ROLE_NAME" ]; then
  echo "Usage: ./deploy-vpc-dev.sh <profile-name> <account-id> <role-name>"
  exit 1
fi

echo "💻 -> 🆙 Deploying VPC emartstore-dev-vpc-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/vpc.yaml \
  --stack-name emartstore-dev-vpc-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-igw-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/internet-gateway.yaml \
  --stack-name emartstore-dev-igw-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-route-tables-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/route-tables.yaml \
  --stack-name emartstore-dev-route-tables-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-subnets-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/subnets.yaml \
  --stack-name emartstore-dev-subnets-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-nat-gateway-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/nat-gateway.yaml \
  --stack-name emartstore-dev-nat-gateway-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-security-groups-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/security-groups.yaml \
  --stack-name emartstore-dev-security-groups-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-nacls-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/nacls.yaml \
  --stack-name emartstore-dev-nacls-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-alb-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/alb.yaml \
  --stack-name emartstore-dev-alb-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-db-subnet-group-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/database-subnet-group.yaml \
  --stack-name emartstore-dev-db-subnet-group-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV
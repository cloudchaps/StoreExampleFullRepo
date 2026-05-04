#!/bin/bash

set -e

PROFILE_NAME=$1
ACCOUNT_ID=$2
ROLE_NAME=$3

if [ -z "$PROFILE_NAME" ] || [ -z "$ACCOUNT_ID" ] || [ -z "$ROLE_NAME" ]; then
  echo "Usage: ./deploy-vpc-dev.sh <profile-name> <account-id> <role-name>"
  exit 1
fi

echo "💻 -> 🆙 Deploying VPC emartstore-dev-networking-vpc-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/vpc.yaml \
  --stack-name emartstore-dev-networking-vpc-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-networking-igw-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/internet-gateway.yaml \
  --stack-name emartstore-dev-networking-igw-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-networking-route-tables-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/route-tables.yaml \
  --stack-name emartstore-dev-networking-route-tables-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-networking-subnets-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/subnets.yaml \
  --stack-name emartstore-dev-networking-subnets-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-networking-nat-gateway-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/nat-gateway.yaml \
  --stack-name emartstore-dev-networking-nat-gateway-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-networking-security-groups-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/security-groups.yaml \
  --stack-name emartstore-dev-networking-security-groups-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-networking-nacls-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/nacls.yaml \
  --stack-name emartstore-dev-networking-nacls-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-networking-alb-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/alb.yaml \
  --stack-name emartstore-dev-networking-alb-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying VPC emartstore-dev-networking-db-subnet-group-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/networking/database-subnet-group.yaml \
  --stack-name emartstore-dev-networking-db-subnet-group-stack \
  --parameter-overrides file://../parameters/dev/networking.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV
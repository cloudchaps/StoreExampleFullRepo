#!/bin/bash

set -e

PROFILE_NAME=$1
ACCOUNT_ID=$2
ROLE_NAME=$3

if [ -z "$PROFILE_NAME" ] || [ -z "$ACCOUNT_ID" ] || [ -z "$ROLE_NAME" ]; then
  echo "Usage: ./deploy-vpc-dev.sh <profile-name> <account-id> <role-name>"
  exit 1
fi

echo "💻 -> 🆙 Deploying Compute emartstore-dev-frontend-servers-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation deploy \
  --template-file ../templates/compute/ec2.yaml \
  --stack-name emartstore-dev-frontend-servers-stack \
  --parameter-overrides file://../parameters/dev/compute.json \
  --profile ${PROFILE_NAME} \
  --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME} \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV
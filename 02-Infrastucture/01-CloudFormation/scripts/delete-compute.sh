#!/bin/bash

set -e

PROFILE_NAME=$1
ACCOUNT_ID=$2
ROLE_NAME=$3

if [ -z "$PROFILE_NAME" ] || [ -z "$ACCOUNT_ID" ] || [ -z "$ROLE_NAME" ]; then
  echo "Usage: ./deploy-vpc-dev.sh <profile-name> <account-id> <role-name>"
  exit 1
fi

echo "💻 -> 🔻 Deleting COMPUTE emartstore-dev-compute-frontend-servers with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-compute-frontend-servers-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}
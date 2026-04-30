#!/bin/bash

set -e

PROFILE_NAME=$1
ACCOUNT_ID=$2
ROLE_NAME=$3

if [ -z "$PROFILE_NAME" ] || [ -z "$ACCOUNT_ID" ] || [ -z "$ROLE_NAME" ]; then
  echo "Usage: ./deploy-vpc-dev.sh <profile-name> <account-id> <role-name>"
  exit 1
fi

echo "💻 -> 🔻 Deleting VPC emartstore-dev-nacls-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-nacls-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 300

echo "💻 -> 🔻 Deleting VPC emartstore-dev-security-groups-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-security-groups-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 300

echo "💻 -> 🔻 Deleting VPC emartstore-dev-nat-gateway-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-nat-gateway-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 300

echo "💻 -> 🔻 Deleting VPC emartstore-dev-subnets-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-subnets-stack  \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 300

echo "💻 -> 🔻 Deleting VPC emartstore-dev-igw-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-igw-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 300

echo "💻 -> 🔻 Deleting VPC emartstore-dev-vpc-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-vpc-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}
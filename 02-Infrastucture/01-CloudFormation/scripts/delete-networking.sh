#!/bin/bash

set -e

PROFILE_NAME=$1
ACCOUNT_ID=$2
ROLE_NAME=$3

if [ -z "$PROFILE_NAME" ] || [ -z "$ACCOUNT_ID" ] || [ -z "$ROLE_NAME" ]; then
  echo "Usage: ./deploy-vpc-dev.sh <profile-name> <account-id> <role-name>"
  exit 1
fi

echo "💻 -> 🔻 Deleting VPC emartstore-dev-networking-db-subnet-group-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-networking-db-subnet-group-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 200

echo "💻 -> 🔻 Deleting VPC emartstore-dev-networking-alb-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-networking-alb-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 200

echo "💻 -> 🔻 Deleting VPC emartstore-dev-networking-nacls-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-networking-nacls-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 200

echo "💻 -> 🔻 Deleting VPC emartstore-dev-networking-security-groups-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-networking-security-groups-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 200

echo "💻 -> 🔻 Deleting VPC emartstore-dev-networking-nat-gateway-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-networking-nat-gateway-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 200

echo "💻 -> 🔻 Deleting VPC emartstore-dev-networking-subnets-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-networking-subnets-stack  \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 200

echo "💻 -> 🔻 Deleting VPC emartstore-dev-networking-route-tables-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-networking-route-tables-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 200

echo "💻 -> 🔻 Deleting VPC emartstore-dev-networking-igw-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-networking-igw-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}

sleep 200

echo "💻 -> 🔻 Deleting VPC emartstore-dev-networking-vpc-stack with ${PROFILE_NAME} profile assuming ${ROLE_NAME} role"
aws cloudformation delete-stack \
    --stack-name emartstore-dev-networking-vpc-stack \
    --profile ${PROFILE_NAME} \
    --role-arn arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}
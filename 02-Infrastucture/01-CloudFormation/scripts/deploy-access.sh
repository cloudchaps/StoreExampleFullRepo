#!/bin/bash

set -e

PROFILE_NAME=$1

if [ -z "$PROFILE_NAME" ]  ; then
  echo "Usage: ./deploy-access.sh <profile-name>"
  exit 1
fi

echo "💻 -> 🆙 Deploying IAM emartstore-dev-iam-policies-stack with ${PROFILE_NAME} profile "
aws cloudformation deploy \
  --template-file ../templates/access/policies.yaml \
  --stack-name emartstore-dev-iam-policies-stack \
  --parameter-overrides file://../parameters/dev/access.json \
  --profile ${PROFILE_NAME} \
  --capabilities CAPABILITY_NAMED_IAM \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying IAM emartstore-dev-iam-users-stack with ${PROFILE_NAME} profile "
aws cloudformation deploy \
  --template-file ../templates/access/users.yaml \
  --stack-name emartstore-dev-iam-users-stack \
  --parameter-overrides file://../parameters/dev/access.json \
  --profile ${PROFILE_NAME} \
  --capabilities CAPABILITY_NAMED_IAM \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV

echo "💻 -> 🆙 Deploying IAM emartstore-dev-iam-roles-stack with ${PROFILE_NAME} profile "
aws cloudformation deploy \
  --template-file ../templates/access/roles.yaml \
  --stack-name emartstore-dev-iam-roles-stack \
  --parameter-overrides file://../parameters/dev/access.json \
  --profile ${PROFILE_NAME} \
  --capabilities CAPABILITY_NAMED_IAM \
  --tags \
    Project=CloudChaps_Resorts \
    Environment=DEV
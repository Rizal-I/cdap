#!/bin/bash

# Define the CDAP endpoint
CDAP_ENDPOINT="http://localhost:11011/api"

# Define the namespace
NAMESPACE="default"

# Define the directory containing the JSON files
DIR="${PWD}/default"

# Loop through each JSON file in the directory
for FILE in "$DIR"/*.json; do
  # Get the name of the JSON file
  FILE_NAME="${FILE##*/}"

  # Skip the pipeline_upgrade.json file
  if [ "$FILE_NAME" == "pipeline_upgrade.json" ]; then
    continue
  fi

  # Get the application name from the JSON file name (remove the .json extension)
  APP_NAME="${FILE%.*}"
  APP_NAME="${APP_NAME##*/}"

  # Print the deployment status
  echo "Deploying ${APP_NAME}..."

  # Deploy the application using curl
  RESPONSE=$(curl -X PUT "${CDAP_ENDPOINT}/v3/namespaces/${NAMESPACE}/apps/${APP_NAME}" -d "@${FILE}" -s)

  # Check the response for the string "Deploy Complete"
  if echo "$RESPONSE" | grep -q "Deploy Complete"; then
    echo "Deployed: ${APP_NAME}"
  else
    echo "Error: Failed to deploy ${APP_NAME}"
  fi
done

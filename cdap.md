# RUN CDAP AKA Cloud Data Fusion SANDBOX

### open our beloved cloudshell

https://shell.cloud.google.com/

### clone this repository

```sh
git clone https://github.com/Rizal-I/cdap.git
cd cdap
```

### run cdap sandbox 

```sh
docker run -it -p 11015:11015 -p 11011:11011 --name cdap-sandbox caskdata/cdap-sandbox:6.7.3 cdap sandbox start --enable-debug --foreground
```
### view UI of CDAP
web preview change 8080 to port 11011

### deploy multiple json pipeline via REST API

```sh
CDAP_ENDPOINT=http://localhost:11011/api
chmod +x filename.sh
./filename.sh
```

## get the pipeline

```sh
curl -X GET "${CDAP_ENDPOINT}/v3/export/apps" -o app.zip
unzip app.zip 
rm app.zip
```
select replace for All


## simulate lost pipeline

### check list of apps

```sh
curl -X GET "${CDAP_ENDPOINT}/v3/namespaces/default/apps" | jq .
```
### delete pipeline

```sh
curl -X DELETE "${CDAP_ENDPOINT}/v3/namespaces/default/apps"
```
### check list of apps

```sh
curl -X GET "${CDAP_ENDPOINT}/v3/namespaces/default/apps" | jq .
```

## restore the pipeline
we can use deploy multiple json pipeline

```sh
#!/bin/bash

# Define the CDAP endpoint
CDAP_ENDPOINT="https://test-instance-data-platform-dev-landing-dot-ase2.datafusion.googleusercontent.com"

# Define the namespace
NAMESPACE="default"

# Define the directory containing JSON pipeline files
PIPELINE_DIR="${PWD}/default"

# Obtain the access token
ACCESS_TOKEN=$(gcloud auth application-default print-access-token)

# Loop through each JSON file in the directory
for pipeline_file in "$PIPELINE_DIR"/*.json; do
  # Extract the base name of the file (without path and extension)
  pipeline_name=$(basename "$pipeline_file" .json)
  
  # Deploy the pipeline
  curl -H "Authorization: Bearer ${ACCESS_TOKEN}" \
       -X PUT "${CDAP_ENDPOINT}/api/v3/namespaces/${NAMESPACE}/apps/${pipeline_name}" \
       -d "@${pipeline_file}"

  # Check the exit status of the curl command
  if [ $? -ne 0 ]; then
    echo "Failed to deploy pipeline: ${pipeline_name}"
  else
    echo "Successfully deployed pipeline: ${pipeline_name}"
  fi
done

```

if we want only some pipeline then use below
### deploy single json

```sh
curl -X PUT "${CDAP_ENDPOINT}/v3/namespaces/default/apps/pipeline-3" -d "@${PWD}/default/pipepline-3.json"
```


### Upgrade pipelines by following these steps:
upgdrading pipeline is for use the latest plugin version installed on new CDAP version for get better performance

1. Create a variable that points to the pipeline_upgrade.json file that you will create in the next step to save a list of pipelines.
   ```sh
   export PIPELINE_LIST=${PWD}/default/pipeline_upgrade.json
   ```
2. Create a list of all pipelines for an instance and namespace using the following command. The result is stored in the $PIPELINE_LIST file in JSON format. You can edit the list to remove pipelines that don't need upgrades.
   ```sh
   curl -H "Content-Type: application/json" ${CDAP_ENDPOINT}/v3/namespaces/default/apps -o $PIPELINE_LIST
   ```
3. Upgrade the pipelines listed in pipeline_upgrade.json. Insert the NAMESPACE_ID of pipelines to be upgraded. The command displays a list of upgraded pipelines with their upgrade status.
   ```sh
   curl -N -H "Content-Type: application/json" ${CDAP_ENDPOINT}/v3/namespaces/default/upgrade --data @$PIPELINE_LIST
   ```




### reference
https://cloud.google.com/data-fusion/docs/how-to/upgrading
https://cdap.atlassian.net/wiki/spaces/DOCS/pages/480379010/Installing+the+CDAP+Sandbox+Docker+Image
https://cloud.google.com/data-fusion/docs/troubleshoot

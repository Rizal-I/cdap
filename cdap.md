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

## get the pipeline

```sh
CDAP_ENDPOINT=http://localhost:11011/api
curl -X GET "${CDAP_ENDPOINT}/v3/export/apps" -o app.zip
unzip app.zip 
rm app.zip
cd default
```

### deploy multiple json pipeline

```sh
chmod +x filename.sh
./filename.sh
```

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

if we want only some pipeline then use below
### deploy single json

```sh
curl -X PUT "${CDAP_ENDPOINT}/v3/namespaces/default/apps/pipeline-3" -d "@/home/rizal_santoso/cdap/default/pipepline-3.json"
```

### reference
https://cloud.google.com/data-fusion/docs/how-to/upgrading
https://cdap.atlassian.net/wiki/spaces/DOCS/pages/480379010/Installing+the+CDAP+Sandbox+Docker+Image

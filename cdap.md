https://cdap.atlassian.net/wiki/spaces/DOCS/pages/480379010/Installing+the+CDAP+Sandbox+Docker+Image

```sh
docker run -it -p 11015:11015 -p 11011:11011 --name cdap-sandbox caskdata/cdap-sandbox:6.7.3 cdap sandbox start --enable-debug --foreground
```

## get the pipeline

```sh
CDAP_ENDPOINT=http://localhost:11011/api
curl -X GET "${CDAP_ENDPOINT}/v3/export/apps" -o app.zip
unzip app.zip 
rm app.zip
```
## restore the pipeline

simulate lost pipeline

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
### deploy multiple json pipeline

```sh
chmod +x filename.sh
```
```sh
./filename.sh
```

### deploy every single json

```sh
curl -X PUT "${CDAP_ENDPOINT}/v3/namespaces/default/apps/pipeline-3" -d "@/home/rizal_santoso/cdap/default/pipepline-3.json"
```
https://cloud.google.com/data-fusion/docs/how-to/upgrading

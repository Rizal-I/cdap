https://cdap.atlassian.net/wiki/spaces/DOCS/pages/480379010/Installing+the+CDAP+Sandbox+Docker+Image

docker run -it -p 11015:11015 -p 11011:11011 --name cdap-sandbox caskdata/cdap-sandbox:6.7.3 cdap sandbox start --enable-debug --foreground


## get the pipeline

CDAP_ENDPOINT=http://localhost:11011/api

curl -X GET "${CDAP_ENDPOINT}/v3/export/apps" -o app.zip
unzip app.zip 
rm app.zip
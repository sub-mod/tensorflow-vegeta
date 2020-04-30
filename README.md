# tensorflow-vegeta

Build Image  
```
docker build --rm -t submod/tf-vegeta -f Dockerfile .
```

Run Image  
```
podman run --rm -it \
    -e REQUEST_RATE_PER_SEC=100 -e DURATION=60s \
    -e ROUTE_FROM_ENV=http://digit-recognition-server-thoth-prod-tensorflow.cloud.paas.psi.redhat.com/v1/models/mnist:predict \
    submod/tf-vegeta:latest /bin/bash
```

quay.io Image  
```
quay.io/sub_mod/tf-vegeta:latest
```

Openshift deploy    
```
oc apply -f template.yml
oc new-app --template=tf-vegeta  --param=DURATION=300s --param=REQUEST_RATE_PER_SEC=1000 --param=ROUTE_FROM_ENV="http://ocp-server.com/v1/models/mnist:predict"

oc delete all -l appTypes=tf-vegeta
oc delete template tf-vegeta
```

Run Locally    
```
vegeta attack -duration=120s -rate=400 -targets=target.list -output=results.bin
vegeta plot -title=Results results.bin > results.html
vegeta report results.bin
cat results.bin | vegeta report -type="hist[0,100ms,200ms,300ms]"
# https://www.scaleway.com/en/docs/vegeta-load-testing/
```

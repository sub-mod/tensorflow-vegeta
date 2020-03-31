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

oc delete all -l appTypes=tf-vegeta
oc delete template tf-vegeta
```

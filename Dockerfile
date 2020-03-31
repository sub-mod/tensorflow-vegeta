#FROM golang
FROM registry.access.redhat.com/ubi8/go-toolset
LABEL maintainer="Subin M <smodeel@redhat.com>"
ENV GOPATH=$APP_ROOT \
    GOBIN=$APP_ROOT/bin

ADD payload.json $APP_ROOT/src/
ADD run.sh $APP_ROOT/src/

USER root
# below commands need root
RUN go get -u github.com/tsenart/vegeta && \
    chown -R 1001:0 ${APP_ROOT} && \
    fix-permissions ${APP_ROOT} -P

USER 1001

# Set the default CMD to print the usage of the language image.
CMD $STI_SCRIPTS_PATH/usage
#!/bin/sh

LABEL="name=jmxclient"

function cleanup() {
    oc delete pods,services,routes -l "$LABEL" --ignore-not-found=true
}

function oc_expose() {
    cleanup
    sleep 5
    oc expose -l "$LABEL" svc/jmx-client
}

trap cleanup EXIT
oc_expose 2>&1 >/dev/null &
oc run \
    --labels="$LABEL" \
    --restart=Never \
    --rm \
    --attach --stdin --tty \
    --port=8080 --expose \
    --image=docker.io/andrewazores/container-jmx-client:latest --image-pull-policy=Always \
    jmx-client "$@"

#!/bin/sh

set -x
set -e

LABEL="name=jmxclient"

function oc_expose() {
    sleep 10 # TODO replace this with a proper wait for the pod to be available
    oc expose -l "$LABEL" svc/jmx-client
}

oc_expose > /dev/null 2>&1 &

oc run \
    --labels="$LABEL" \
    --restart=Never \
    --port=8080 --expose \
    --image=docker.io/andrewazores/container-jmx-client:latest --image-pull-policy=Always \
    -- jmx-client -d

#!/bin/sh

oc new-app --name jmx-listener docker.io/andrewazores/container-jmx-docker-listener
oc set probe --readiness --liveness --open-tcp=9090 dc/jmx-listener

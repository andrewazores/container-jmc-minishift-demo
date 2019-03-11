#!/bin/sh

HOST="$(oc get route/jmx-client | sed -n 2p | tr -s ' ' | cut -d ' ' -f 2)"
wget "http://$HOST/$1" -O "$1.jfr"

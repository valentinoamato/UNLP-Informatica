#!/bin/bash
set -e

mkdir -p out

CP=$(printf '%s:' libs/*.jar)
CP=${CP%:}

kotlinc src/roborts/*.kt \
    -classpath "$CP" \
    -d out


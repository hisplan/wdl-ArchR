#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    ArchR.wdl \
    --inputs ArchR.inputs.json

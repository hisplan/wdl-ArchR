#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    ArchR.wdl \
    --inputs ./configs/dev.inputs.aws.json

#!/usr/bin/env bash -e

java -jar ~/Applications/womtool.jar \
    validate \
    ArchRSA.wdl \
    --inputs ./configs/dev-fragments.inputs.aws.json

java -jar ~/Applications/womtool.jar \
    validate \
    ArchRCR.wdl \
    --inputs ./configs/dev-fastq.inputs.aws.json

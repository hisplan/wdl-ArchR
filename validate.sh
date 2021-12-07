#!/usr/bin/env bash -e

if [ -z $SCING_HOME ]
then
    echo "Environment variable 'SCING_HOME' not defined."
    exit 1
fi

java -jar ${SCING_HOME}/devtools/womtool.jar \
    validate \
    ArchRSA.wdl \
    --inputs ./configs/dev-fragments.inputs.aws.json

java -jar ${SCING_HOME}/devtools/womtool.jar \
    validate \
    ArchRCR.wdl \
    --inputs ./configs/dev-fastq.inputs.aws.json

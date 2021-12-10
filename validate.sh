#!/usr/bin/env bash -e

if [ -z $SCING_HOME ]
then
    echo "Environment variable 'SCING_HOME' not defined."
    exit 1
fi

java -jar ${SCING_HOME}/devtools/womtool.jar \
    validate \
    ArchRSA.wdl \
    --inputs ./configs/template.fragments.inputs.json

java -jar ${SCING_HOME}/devtools/womtool.jar \
    validate \
    ArchRCR.wdl \
    --inputs ./configs/template.fastq.inputs.json

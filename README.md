# wdl-ArchR

## Dependencies

```bash
conda install -c bioconda cromwell-tools
conda install -c cyclus java-jre
```

## Run

```bash
$ ./submit.sh \
    -k ~/keys/secrets-aws.json \
    -i ./configs/dev.inputs.aws.json \
    -l ./configs/dev.labels.aws.json \
    -o ArchR.options.aws.json
```

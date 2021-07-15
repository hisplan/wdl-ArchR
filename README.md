# wdl-ArchR

## Dependencies

```bash
conda install -c bioconda cromwell-tools
conda install -c cyclus java-jre
```

## Using FASTQ as Input

This will run Cell Ranger ATAC first to generate fragments file, then feed the fragments file into ArchR as input.

### Submitting Jobs

```bash
$ ./submit-fastq.sh \
    -k ~/keys/secrets-aws.json \
    -i ./configs/dev-fastq.inputs.aws.json \
    -l ./configs/dev-fastq.labels.aws.json \
    -o ArchR.options.aws.json
```

## Using Fragments as Input

This is useful if you already have fragments file in your hand

### Generating Config File

`wdl-ArchR` requires a fragments file generated by Cell Ranger ATAC.

Expecting directory structure in AWS S3:

```
s3://dp-lab-data
└── collaborators
    └── hadjanta
        └── scATAC_embryo_gut_tube
            └── Lib1_Ant-1
                └── CR-results
                    └── count
                        └── outs
```

where
  - `hadjanta`: lab name (as stored in SCRI database & S3)
  - `scATAC_embryo_gut_tube`: project name (as stored in SCRI database & S3)
  - `Lib1_Ant-1`: sample name (as stored in SCRI database & S3)
  - `fragments.tsv.gz` should be found in the `outs` directory.

In case there are multiple samples:

```
$ aws s3 ls s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/
    PRE Lib1_Ant-1/
    PRE Lib2_Ant-2/
    PRE LIb3_Post-1/
    PRE Lib4_Post-2/
    PRE Lib5_guttube_GFPpos_1/
    PRE Lib6_guttube_GFPneg_1/
    PRE LIb7_guttube_GFPpos_2/
    PRE Lib8_guttube_GFPneg_2/
```

```
$ python create_config.py \
    --s3-prefix s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube \
    --genome mm10 \
    --software cr \
    --sample-names Lib1_Ant-1 Lib2_Ant-2 LIb3_Post-1 Lib4_Post-2 Lib5_guttube_GFPpos_1 Lib6_guttube_GFPneg_1 LIb7_guttube_GFPpos_2 Lib8_guttube_GFPneg_2
```

Output:

```
{
    "ArchR.genome": "mm10",
    "ArchR.fragmentsFiles": [
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib1_Ant-1/CR-results/count/outs/fragments.tsv.gz",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib2_Ant-2/CR-results/count/outs/fragments.tsv.gz",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/LIb3_Post-1/CR-results/count/outs/fragments.tsv.gz",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib4_Post-2/CR-results/count/outs/fragments.tsv.gz",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib5_guttube_GFPpos_1/CR-results/count/outs/fragments.tsv.gz",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib6_guttube_GFPneg_1/CR-results/count/outs/fragments.tsv.gz",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/LIb7_guttube_GFPpos_2/CR-results/count/outs/fragments.tsv.gz",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib8_guttube_GFPneg_2/CR-results/count/outs/fragments.tsv.gz"
    ],
    "ArchR.fragmentsIndexFiles": [
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib1_Ant-1/CR-results/count/outs/fragments.tsv.gz.tbi",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib2_Ant-2/CR-results/count/outs/fragments.tsv.gz.tbi",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/LIb3_Post-1/CR-results/count/outs/fragments.tsv.gz.tbi",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib4_Post-2/CR-results/count/outs/fragments.tsv.gz.tbi",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib5_guttube_GFPpos_1/CR-results/count/outs/fragments.tsv.gz.tbi",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib6_guttube_GFPneg_1/CR-results/count/outs/fragments.tsv.gz.tbi",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/LIb7_guttube_GFPpos_2/CR-results/count/outs/fragments.tsv.gz.tbi",
        "s3://dp-lab-data/collaborators/hadjanta/scATAC_embryo_gut_tube/Lib8_guttube_GFPneg_2/CR-results/count/outs/fragments.tsv.gz.tbi"
    ],
    "ArchR.sampleNames": [
        "Lib1_Ant-1",
        "Lib2_Ant-2",
        "LIb3_Post-1",
        "Lib4_Post-2",
        "Lib5_guttube_GFPpos_1",
        "Lib6_guttube_GFPneg_1",
        "LIb7_guttube_GFPpos_2",
        "Lib8_guttube_GFPneg_2"
    ]
}
```

### Submitting Jobs

```bash
$ ./submit-fragments.sh \
    -k ~/keys/secrets-aws.json \
    -i ./configs/dev-fragments.inputs.aws.json \
    -l ./configs/dev-fragments.labels.aws.json \
    -o ArchR.options.aws.json
```

## Understanding Outputs

The pipeline performs SVD, PhenoGraph clustering, UMAP, peak calling, gene score, and etc. Then with all these, it generates an AnnData (`.h5ad`). You can explore the structure of the AnnData (e.g. `obs`, `var`, ...) using this simple notebook: [explore-ArchR-adata.ipynb](./docs/explore-ArchR-adata.ipynb)

Being an automated pipeline, it uses default values for some parameters. Sometimes you might want to tweak these parameters and start from scratch. In that case, you can start from an Arrow file, or even go further upstream, take the fragments file from the Cell Ranger ATAC/ARC output, and run ArchR from the beginning. Here's what you would find under the archr-results directory:

- `arrows/*`: ArchR arrow file
- `project.tgz`: ArchR project file along with intermediate output files (tar-gzipped)
- `preprocessed.h5ad`: AnnData that I mentioned above
- `qc/*` : QC files
- `logs/*` : log files

```
.
├── arrows
│   └── *.arrow
├── preprocessed.h5ad
├── project.tgz
├── *-metadata.json
├── filelist-all.txt
├── logs
│   ├── ArchR-addClusters-**.log
│   ├── ArchR-addGeneScoreMatrix-*.log
│   ├── ArchR-addGroupCoverages-*.log
│   ├── ArchR-addIterativeLSI-*.log
│   ├── ArchR-addPeakMatrix-*.log
│   ├── ArchR-addReproduciblePeakSet-*.log
│   ├── ArchR-createArrows-*.log
│   ├── ArchR-getMatrixFromProject-*.log
│   ├── ArchR-getMatrixFromProject-*.log
│   └── ArchR-plotEmbedding-*.log
└── qc
    ├── *-Fragment_Size_Distribution.pdf
    ├── *-Pre-Filter-Metadata.rds
    └── **-TSS_by_Unique_Frags.pdf
```

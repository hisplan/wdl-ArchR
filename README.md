# wdl-ArchR

- `ArchRSA`: ArchR Stand-Alone (using fragments files as input)
- `ArchRCR`: Cell Ranger ATAC + ArchR (using FASTQ files as input)

## License

The pipeline code is available to everyone under the standard [MIT license](./LICENSE). However, the pipeline internally uses 10x software for certain steps if necessary, so please make sure that you read and agree to [10x End User Software License](https://www.10xgenomics.com/end-user-software-license-agreement).

## Setup

The pipeline is a part of SCING (Single-Cell pIpeliNe Garden; pronounced as "sing" /siŋ/). For setup, please refer to [this page](https://github.com/hisplan/scing). All the instructions below is given under the assumption that you have already configured SCING in your environment.

## ArchRSA: Using FASTQ as Input

This will run Cell Ranger ATAC first to generate fragments file, then feed the fragments file into ArchR as input.

### Reference

#### Human

```
"ArchRCR.genomeCellRanger": {
    "name": "GRCh38-2020-A-2.0.0",
    "location": "https://cf.10xgenomics.com/supp/cell-atac/refdata-cellranger-arc-GRCh38-2020-A-2.0.0.tar.gz"
},
"ArchRCR.genomeArchR": "hg38"
```

#### Mouse

```
"ArchRCR.genomeCellRanger": {
    "name": "mm10-2020-A-2.0.0",
    "location": "https://cf.10xgenomics.com/supp/cell-atac/refdata-cellranger-arc-mm10-2020-A-2.0.0.tar.gz"
},
"ArchRCR.genomeArchR": "mm10"
```

### Submitting Jobs

```bash
$ ./submit-fastq.sh \
    -k ~/keys/secrets-aws.json \
    -i ./configs/pbmc_500_v1.fastq.inputs.json \
    -l ./configs/pbmc_500_v1.fastq.labels.json \
    -o ArchR.options.aws.json
```

## ArchRCR: Using Fragments Files as Input

This is useful if you already have fragments file in your hand

### Submitting Jobs

```bash
$ ./submit-fragments.sh \
    -k ~/keys/secrets-aws.json \
    -i ./configs/pbmc_500_v1.fragments.inputs.json \
    -l ./configs/pbmc_500_v1.fragments.labels.json \
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

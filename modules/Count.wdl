version 1.0

task Count {

    input {
        String sampleName
        String fastqNames
        Array[File] fastqFiles
        Map[String, String] referenceGenome
    }

    String cellRangerAtacVersion = "1.2.0"
    String dockerImage = "hisplan/cellranger-atac:" + cellRangerAtacVersion
    Float inputSize = size(fastqFiles, "GiB")

    # ~{sampleName} : the top-level output directory containing pipeline metadata
    # ~{sampleName}/outs/ : contains the final pipeline output files.
    String outBase = sampleName + "/outs"

    command <<<
        set -euo pipefail

        export MRO_DISK_SPACE_CHECK=disable

        df -h
        find .

        path_input=`dirname ~{fastqFiles[0]}`

        echo ${path_input}

        # download reference
        curl -L --silent -o reference.tgz ~{referenceGenome["location"]}
        mkdir -p reference
        tar xvzf reference.tgz -C reference --strip-components=1
        chmod -R +r reference
        rm -rf reference.tgz

        find .
        df -h

        # run pipeline
        cellranger-atac count \
            --uiport=3600 \
            --id=~{sampleName} \
            --reference=./reference/ \
            --fastqs=${path_input} \
            --sample=~{fastqNames}

        # targz the analysis folder and pipestance metadata if successful
        if [ $? -eq 0 ]
        then
            tar czf ~{outBase}/analysis.tgz ~{outBase}/analysis/*
            tar czf ~{outBase}/pipestanceMeta.tgz ~{sampleName}/_*
        fi
    >>>

    output {
        File outBam = outBase + "/possorted_bam.bam"
        File outBai = outBase + "/possorted_bam.bam.bai"
        File outSummaryJson = outBase + "/summary.json"
        File outSummaryCsv = outBase + "/summary.csv"
        File outSummaryHtml = outBase + "/web_summary.html"
        File outPeaks = outBase + "/peaks.bed"
        File? outAnalysis = outBase + "/analysis.tgz"
        Array[File] outRawPeakBCMatrix = glob(outBase + "/raw_peak_bc_matrix/*")
        Array[File] outFilteredPeakBCMatrix = glob(outBase + "/filtered_peak_bc_matrix/*")
        Array[File] outFilteredTFBCMatrix = glob(outBase + "/filtered_tf_bc_matrix/*")
        File outLoupe = outBase + "/cloupe.cloupe"
        Array[File] outHDF5 = glob(outBase + "/*.h5")
        File outFragments = outBase + "/fragments.tsv.gz"
        File outFragmentsIndex = outBase + "/fragments.tsv.gz.tbi"
        File outPeakAnnotation = outBase + "/peak_annotation.tsv"
        File outPerBarcodeMetrics = outBase + "/singlecell.csv"
        File outPipestanceMeta = outBase + "/pipestanceMeta.tgz"

        File outReferenceIndex = "reference/fasta/genome.fa.fai"
    }

    runtime {
        docker: dockerImage
        cpu: 15
        memory: "100 GB"
    }
}

version 1.0

import "modules/Count.wdl" as Count

workflow Count {

    input {
        String sampleName
        String fastqNames
        Array[File] fastqFiles
        Map[String, String] referenceGenome

        # docker-related
        String dockerRegistry
    }

    call Count.Count {
        input:
            sampleName = sampleName,
            fastqNames = fastqNames,
            referenceGenome = referenceGenome,
            fastqFiles = fastqFiles,
            dockerRegistry = dockerRegistry
    }

    output {
        File outBam = Count.outBam
        File outBai = Count.outBai

        File outSummaryJson = Count.outSummaryJson
        File outSummaryCsv = Count.outSummaryCsv
        File outSummaryHtml = Count.outSummaryHtml
        File outPerBarcodeMetrics = Count.outPerBarcodeMetrics

        File outPeaks = Count.outPeaks
        File? outAnalysis = Count.outAnalysis

        Array[File] outRawPeakBCMtx = Count.outRawPeakBCMtx
        File outRawPeakBCMtxHdf5 = Count.outRawPeakBCMtxHdf5

        Array[File] outFilteredPeakBCMtx = Count.outFilteredPeakBCMtx
        File outFilteredPeakBCMtxHdf5 = Count.outFilteredPeakBCMtxHdf5

        Array[File] outFilteredTFBCMtx = Count.outFilteredTFBCMtx
        File outFilteredTFBCMtxHdf5 = Count.outFilteredTFBCMtxHdf5

        File outLoupe = Count.outLoupe

        File outFragments = Count.outFragments
        File outFragmentsIndex = Count.outFragmentsIndex

        File outPeakAnnotation = Count.outPeakAnnotation
        File outPeakMotifMapping = Count.outPeakMotifMapping

        File outPipestanceMeta = Count.outPipestanceMeta

    }
}
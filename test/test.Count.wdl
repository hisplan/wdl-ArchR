version 1.0

import "modules/Count.wdl" as Count

workflow Count {

    input {
        String sampleName
        String fastqNames
        Array[File] fastqFiles
        Map[String, String] referenceGenome
    }

    call Count.Count {
        input:
            sampleName = sampleName,
            fastqNames = fastqNames,
            referenceGenome = referenceGenome,
            fastqFiles = fastqFiles
    }

    output {
        File outBam = Count.outBam
        File outBai = Count.outBai
        File outSummaryJson = Count.outSummaryJson
        File outSummaryCsv = Count.outSummaryCsv
        File outSummaryHtml = Count.outSummaryHtml
        File outPeaks = Count.outPeaks
        File? outAnalysis = Count.outAnalysis
        Array[File] outRawPeakBCMatrix = Count.outRawPeakBCMatrix
        Array[File] outFilteredPeakBCMatrix = Count.outFilteredPeakBCMatrix
        Array[File] outFilteredTFBCMatrix = Count.outFilteredTFBCMatrix
        File outLoupe = Count.outLoupe
        Array[File] outHDF5 = Count.outHDF5
        File outFragments = Count.outFragments
        File outFragmentsIndex = Count.outFragmentsIndex
        File outPeakAnnotation = Count.outPeakAnnotation
        File outPerBarcodeMetrics = Count.outPerBarcodeMetrics
        File outPipestanceMeta = Count.outPipestanceMeta

        File outReferenceIndex = Count.outReferenceIndex
    }
}
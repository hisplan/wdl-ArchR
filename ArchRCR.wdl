version 1.0

import "modules/Count.wdl" as Count
import "modules/ReformatFragments.wdl" as ReformatFragments
import "modules/TabixfyFragments.wdl" as TabixfyFragments
import "modules/Preprocess.wdl" as Preprocess
import "modules/ConstructAnnData.wdl" as ConstructAnnData

# ArchR + Cell Ranger (starting from FASTQ)
workflow ArchRCR {

    input {
        String sampleName
        String fastqNames
        Array[File] fastqFiles
        Map[String, String] genomeCellRanger
        String genomeArchR

        Boolean reformatFragments = false

        # ArchR unstable with multiprocessing
        Int numCores
    }

    call Count.Count {
        input:
            sampleName = sampleName,
            fastqNames = fastqNames,
            referenceGenome = genomeCellRanger,
            fastqFiles = fastqFiles
    }

    # reformat fragments only if requested
    if (reformatFragments) {
        call ReformatFragments.ReformatFragments {
            input:
                fragments = Count.outFragments,
                numCores = numCores
        }

        call TabixfyFragments.TabixfyFragments {
            input:
                fragments = ReformatFragments.out
        }
    }

    File finalFragments = select_first([ReformatFragments.out, Count.outFragments])
    File finalFragmentsIndex = select_first([TabixfyFragments.out, Count.outFragmentsIndex])

    call Preprocess.Run {
        input:
            fragmentsFiles = [finalFragments],
            fragmentsIndexFiles = [finalFragmentsIndex],
            sampleNames = [sampleName],
            genome = genomeArchR,
            numCores = numCores
    }

    call ConstructAnnData.ConstructAnnData {
        input:
            exports = Run.exports
    }

    output {

        # Cell Ranger ATAC output
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

        # modified ArchR output
        Array[File] outLogs = Run.logFiles
        Array[File] outQC = Run.qcFiles
        Array[File] outArrow0 = Run.arrowFiles0
        File outProject = Run.projectOutputs
        File outAdata = ConstructAnnData.adata
        File? outFileList = Run.fileList
    }
}

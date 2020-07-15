version 1.0

import "modules/Preprocess.wdl" as Preprocess
import "modules/ConstructAnnData.wdl" as ConstructAnnData

workflow ArchR {

    input {
        Array[File] fragmentsFiles
        Array[File] fragmentsIndexFiles
        Array[String] sampleNames
        String genome
    }

    call Preprocess.Run {
        input:
            fragmentsFiles = fragmentsFiles,
            fragmentsIndexFiles = fragmentsIndexFiles,
            sampleNames = sampleNames,
            genome = genome
    }

    call ConstructAnnData.ConstructAnnData {
        input:
            exports = Run.exports
    }

    output {
        Array[File] logFiles = Run.logFiles
        Array[File] qcFiles = Run.qcFiles
        Array[File] arrowFiles = Run.arrowFiles
        Array[File] lsiFiles = Run.lsiFiles
        Array[File] embeddingFiles = Run.embeddingFiles
        Array[File] plotFiles = Run.plotFiles
        File projectFile = Run.projectFile
        File adata = ConstructAnnData.adata
        File? fileList = Run.fileList
    }
}

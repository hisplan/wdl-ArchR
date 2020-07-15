version 1.0

import "modules/Preprocess.wdl" as Preprocess

workflow Run {

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

    output {
        Array[File] logFiles = Run.logFiles
        Array[File] qcFiles = Run.qcFiles
        Array[File] arrowFiles = Run.arrowFiles
        Array[File] lsiFiles = Run.lsiFiles
        Array[File] embeddingFiles = Run.embeddingFiles
        Array[File] plotFiles = Run.plotFiles
        File projectFile = Run.projectFile
        File exports = Run.exports
        File? fileList = Run.fileList
    }
}

version 1.0

import "modules/Preprocess.wdl" as Preprocess

workflow Preprocess {

    input {
        File tutorialCode
    }

    call Preprocess.RunTutorial {
        input:
            tutorialCode = tutorialCode
    }

    output {
        Array[File] logFiles = RunTutorial.logFiles
        Array[File] qcFiles = RunTutorial.qcFiles
        Array[File] arrowFiles = RunTutorial.arrowFiles
        Array[File] lsiFiles = RunTutorial.lsiFiles
        Array[File] embeddingFiles = RunTutorial.embeddingFiles
        Array[File] plotFiles = RunTutorial.plotFiles
        File projectFile = RunTutorial.projectFile
        File? fileList = RunTutorial.fileList
    }
}
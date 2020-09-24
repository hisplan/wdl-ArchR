version 1.0

import "modules/Preprocess.wdl" as Preprocess

workflow RunTutorial {

    input {
        File tutorialCode
        String outputDir
    }

    call Preprocess.RunTutorial {
        input:
            tutorialCode = tutorialCode,
            outputDir = outputDir
    }

    output {
        Array[File] logFiles = RunTutorial.logFiles
        Array[File] qcFiles = RunTutorial.qcFiles
        Array[File] arrowFiles0 = RunTutorial.arrowFiles0
        Array[File] arrowFiles = RunTutorial.arrowFiles
        Array[File] lsiFiles = RunTutorial.lsiFiles
        Array[File] embeddingFiles = RunTutorial.embeddingFiles
        Array[File] plotFiles = RunTutorial.plotFiles
        File projectFile = RunTutorial.projectFile
        File? fileList = RunTutorial.fileList
    }
}

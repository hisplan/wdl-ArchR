version 1.0

import "modules/ReformatFragments.wdl" as ReformatFragments
import "modules/TabixfyFragments.wdl" as TabixfyFragments
import "modules/Preprocess.wdl" as Preprocess
import "modules/ConstructAnnData.wdl" as ConstructAnnData

workflow ArchR {

    input {
        Array[File] fragmentsFiles
        Array[File] fragmentsIndexFiles
        Array[String] sampleNames
        String genome

        # ArchR unstable with multiprocessing
        Int numCores
    }

    scatter (fragments in fragmentsFiles) {
        call ReformatFragments.ReformatFragments {
            input:
                fragments = fragments,
                numCores = numCores
        }
        call TabixfyFragments.TabixfyFragments {
            input:
                fragments = ReformatFragments.out
        }
    }

    call Preprocess.Run {
        input:
            fragmentsFiles = ReformatFragments.out,
            fragmentsIndexFiles = TabixfyFragments.out,
            sampleNames = sampleNames,
            genome = genome,
            numCores = numCores
    }

    call ConstructAnnData.ConstructAnnData {
        input:
            exports = Run.exports
    }

    output {
        Array[File] logFiles = Run.logFiles
        Array[File] qcFiles = Run.qcFiles
        Array[File] arrowFiles0 = Run.arrowFiles0
        # Array[File] arrowFiles = Run.arrowFiles
        # Array[File] lsiFiles = Run.lsiFiles
        # Array[File] embeddingFiles = Run.embeddingFiles
        # Array[File] plotFiles = Run.plotFiles
        # File projectFile = Run.projectFile
        File projectOutputs = Run.projectOutputs
        File adata = ConstructAnnData.adata
        File? fileList = Run.fileList
    }
}

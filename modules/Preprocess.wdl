version 1.0

task RunTutorial {

    input {
        File tutorialCode
        String outputDir
    }

    String dockerImage = "hisplan/archr:0.9.5-snapshot-20200617c"

    command {
        set -euo pipefail

        Rscript ~{tutorialCode}

        find .

        find . > filelist-all.txt
    }

    output {
        Array[File] logFiles = glob("ArchRLogs/*.log")
        Array[File] qcFiles = glob("QualityControl/*/*")
        Array[File] arrowFiles = glob(outputDir + "/ArrowFiles/*.arrow")
        Array[File] lsiFiles = glob(outputDir + "/IterativeLSI/*")
        Array[File] embeddingFiles = glob(outputDir + "/Embeddings/*")
        Array[File] plotFiles = glob(outputDir + "/Plots/*")
        File projectFile = outputDir + "/Save-ArchR-Project.rds"
        File? fileList = "filelist-all.txt"
    }

    runtime {
        docker: dockerImage
        # disks: "local-disk 100 HDD"
        cpu: 16
        memory: "64 GB"
    }
}

task Run {

    input {
        Array[File] fragmentsFiles
        Array[File] fragmentsIndexFiles
        Array[String] sampleNames
        String genome
        Int numCores = 16
        String outputDir = "outs"
    }

    String dockerImage = "hisplan/archr:0.9.5-snapshot-20200617c"

    command {
        set -euo pipefail

        echo "~{sep='\n' fragmentsFiles}" > input-files.txt
        echo "~{sep='\n' sampleNames}" > sample-names.txt

        Rscript /opt/preprocess.R input-files.txt sample-names.txt ~{genome} ~{numCores}

        find . > filelist-all.txt
    }

    output {
        Array[File] logFiles = glob("ArchRLogs/*.log")
        Array[File] qcFiles = glob("QualityControl/*/*")
        Array[File] arrowFiles = glob(outputDir + "/ArrowFiles/*.arrow")
        Array[File] lsiFiles = glob(outputDir + "/IterativeLSI/*")
        Array[File] embeddingFiles = glob(outputDir + "/Embeddings/*")
        Array[File] plotFiles = glob(outputDir + "/Plots/*")
        File projectFile = outputDir + "/Save-ArchR-Project.rds"
        File? fileList = "filelist-all.txt"
    }

    runtime {
        docker: dockerImage
        # disks: "local-disk 100 HDD"
        cpu: numCores
        memory: "128 GB"
    }
}

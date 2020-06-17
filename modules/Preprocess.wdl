version 1.0

task RunTutorial {

    input {
        File tutorialCode
        String outputDir = "HemeTutorial"
    }

    String dockerImage = "hisplan/archr:0.9.x-snapshot-20200617"

    command {
        set -euo pipefail

        # pkgs = c('optparse')
        # install.packages(pkgs, repos='http://cran.us.r-project.org')
        Rscript ~{tutorialCode}

        find .
        # find ./QualityControl/ -type f > filelist-qc.txt
    }

    output {
        Array[File] logFiles = glob("ArchRLogs/*.log")
        Array[File] qcFiles = glob("QualityControl/*/*")
        Array[File] arrowFiles = glob(outputDir + "/ArroFiles/*.arrow")
        Array[File] lsiFiles = glob(outputDir + "/IterativeLSI/*")
        Array[File] embeddingFiles = glob(outputDir + "/Embeddings/*")
        Array[File] plotFiles = glob(outputDir + "/Plots/*")
        File projectFile = outputDir + "/Save-ArchR-Project.rds"
    }

    runtime {
        docker: dockerImage
        # disks: "local-disk 100 HDD"
        cpu: 16
        memory: "64 GB"
    }
}

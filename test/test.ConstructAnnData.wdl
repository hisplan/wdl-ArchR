version 1.0

import "modules/ConstructAnnData.wdl" as ConstructAnnData

workflow ConstructAnnData {

    input {
        File exports
    }

    call ConstructAnnData.ConstructAnnData {
        input:
            exports = exports
    }

    output {
        File adata = ConstructAnnData.adata
    }
}

version 1.0

import "modules/ConstructAnnData.wdl" as ConstructAnnData

workflow ConstructAnnData {

    input {
        File exports

        # docker-related
        String dockerRegistry        
    }

    call ConstructAnnData.ConstructAnnData {
        input:
            exports = exports,
            dockerRegistry = dockerRegistry            
    }

    output {
        File adata = ConstructAnnData.adata
    }
}

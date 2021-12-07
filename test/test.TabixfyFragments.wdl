version 1.0

import "modules/TabixfyFragments.wdl" as TabixfyFragments

workflow TabixfyFragments {

    input {
        File fragments

        # docker-related
        String dockerRegistry
    }

    call TabixfyFragments.TabixfyFragments {
        input:
            fragments = fragments,
            dockerRegistry = dockerRegistry
    }
}

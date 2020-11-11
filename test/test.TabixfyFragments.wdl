version 1.0

import "modules/TabixfyFragments.wdl" as TabixfyFragments

workflow TabixfyFragments {

    input {
        File fragments
    }

    call TabixfyFragments.TabixfyFragments {
        input:
            fragments = fragments
    }
}

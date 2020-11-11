version 1.0

import "modules/ReformatFragments.wdl" as ReformatFragments

workflow ReformatFragments {

    input {
        File fragments
        Int numCores
    }

    call ReformatFragments.ReformatFragments {
        input:
            fragments = fragments,
            numCores = numCores
    }
}

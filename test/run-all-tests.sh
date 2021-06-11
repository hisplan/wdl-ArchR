#!/bin/bash -e

modules="Count TabixfyFragments ReformatFragments ConstructAnnData Preprocess-Run Preprocess-RunTutorial"

for module_name in $modules
do

    echo "Testing ${module_name}..."
    
    ./run-test.sh -k ~/secrets-gcp.json -m ${module_name}

done

#!/usr/bin/env python

import os
import json
import re
import subprocess
import argparse
from collections import defaultdict


def check_if_exists(bucket, key):

    process = subprocess.Popen(
        ["aws", "s3api", "head-object", "--bucket", bucket, "--key", key],
        stdout=subprocess.PIPE,
    )

    process.communicate()

    return process.returncode


def split_s3_uri(s3_uri):

    match = re.search(r"s3://(.*?)/(.*)", s3_uri)
    if not match:
        raise Exception("Invalid S3 URI!", s3_uri)
    return match.groups(1)


def generate(s3_prefix, sample_names, genome, check_exists):

    inputs = defaultdict(list)

    inputs["ArchR.genome"] = genome

    for sample_name in sample_names:

        s3_uri = f"{s3_prefix}/{sample_name}/CR-results/count/outs/fragments.tsv.gz"

        if check_exists:
            bucket, key = split_s3_uri(s3_uri)
            if check_if_exists(bucket, key) != 0:
                raise Exception("Not found!", s3_uri)

        inputs["ArchR.fragmentsFiles"].append(s3_uri)
        inputs["ArchR.fragmentsIndexFiles"].append(s3_uri + ".tbi")
        inputs["ArchR.sampleNames"].append(sample_name)

    print(json.dumps(inputs, indent=4))


def parse_arguments():

    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--s3-prefix",
        action="store",
        dest="s3_prefix",
        help="s3://dp-lab-data/collaborators/${lab}/${project}",
        required=True,
    )

    parser.add_argument(
        "--sample-names",
        action="store",
        nargs="+",
        dest="sample_names",
        help="list of samples (comma-separated)",
        required=True,
    )

    parser.add_argument(
        "--genome",
        action="store",
        dest="genome",
        help="hg19, hg38, mm10",
        required=True,
    )

    # `--dont-check` sets `check_exists` to False
    parser.add_argument(
        "--dont-check",
        action="store_false",
        dest="check_exists",
        default=True,
        help="check if fragments file exists in S3",
    )

    # parse arguments
    params = parser.parse_args()

    return params


if __name__ == "__main__":

    params = parse_arguments()

    generate(
        s3_prefix=params.s3_prefix,
        sample_names=params.sample_names,
        genome=params.genome,
        check_exists=params.check_exists,
    )

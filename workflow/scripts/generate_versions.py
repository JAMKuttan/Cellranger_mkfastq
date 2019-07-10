#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''Make YAML of software versions.'''

from __future__ import print_function
from collections import OrderedDict
import re
import logging
import argparse
import numpy as np

EPILOG = '''
For more details:
        %(prog)s --help
'''

# SETTINGS

logger = logging.getLogger(__name__)
logger.addHandler(logging.NullHandler())
logger.propagate = False
logger.setLevel(logging.INFO)

SOFTWARE_REGEX = {
    'Nextflow': ['version_nextflow.txt', r"(\S+)"],
    'cellranger mkfastq': ['version_cellranger.mkfastq.txt', r"(\S+)"],
    'bcl2fastq': ['version_bcl2fastq.txt', r"(\S+)"],
    'fastqc': ['version_fastqc.txt', r"(\S+)"],
}


def get_args():
    '''Define arguments.'''

    parser = argparse.ArgumentParser(
        description=__doc__, epilog=EPILOG,
        formatter_class=argparse.RawDescriptionHelpFormatter)

    parser.add_argument('-f', '--files',
                        help="The version files.",
                        required=True,
                        nargs='*')

    parser.add_argument('-o', '--output',
                        help="The out file name.",
                        required=True)

    args = parser.parse_args()
    return args


def check_files(files):
    '''Check if version files are found.'''

    logger.info("Running file check.")

    software_files = np.array(list(SOFTWARE_REGEX.values()))[:,0]

    extra_files = set(files) - set(software_files)

    if len(extra_files) > 0:
            logger.error('Missing regex: %s', list(extra_files))
            raise Exception("Missing regex: %s" % list(extra_files))


def main():
    args = get_args()
    files = args.files
    output = args.output

    out_filename = output + '_mqc.yaml'

    results = OrderedDict()
    results['Nextflow'] = '<span style="color:#999999;\">N/A</span>'
    results['cellranger mkfastq'] = '<span style="color:#999999;\">N/A</span>'
    results['bcl2fastq'] = '<span style="color:#999999;\">N/A</span>'
    results['fastqc'] = '<span style="color:#999999;\">N/A</span>'

    # Check for version files:
    check_files(files)

    # Search each file using its regex
    for k, v in SOFTWARE_REGEX.items():
        with open(v[0]) as x:
            versions = x.read()
            match = re.search(v[1], versions)
            if match:
                results[k] = "v{}".format(match.group(1))

    # Dump to YAML
    print(
        '''
        id: 'software_versions'
        section_name: 'Software Versions'
        section_href: 'https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/'
        plot_type: 'html'
        description: 'are collected at run time from the software output.'
        data: |
            <dl class="dl-horizontal">
        '''
    , file = open(out_filename, "w"))

    for k, v in results.items():
        print("            <dt>{}</dt><dd>{}</dd>".format(k, v), file = open(out_filename, "a"))
    print("            </dl>", file = open(out_filename, "a"))


if __name__ == '__main__':
    main()

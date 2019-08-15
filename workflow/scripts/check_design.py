#!/usr/bin/env python3
#check_design.py
#*
#* --------------------------------------------------------------------------
#* Licensed under MIT (https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/blob/develop/LICENSE)
#* --------------------------------------------------------------------------
#*

import argparse
import logging
import pandas as pd

EPILOG = '''
For more details:
        %(prog)s --help
'''

logger = logging.getLogger(__name__)
logger.addHandler(logging.NullHandler())
logger.propagate = False
logger.setLevel(logging.INFO)


def get_args():
    '''Define arguments.'''

    parser = argparse.ArgumentParser(
        description=__doc__, epilog=EPILOG,
        formatter_class=argparse.RawDescriptionHelpFormatter)

    parser.add_argument('-d', '--design',
                        help="The design file to run QC (tsv format).",
                        required=True)

    args = parser.parse_args()
    return args


def check_design_headers(design):
    '''Check if design file has correct headers.'''

    # Default headers
    design_template = [
        'Lane',
        'Sample',
        'Index']

    design_headers = list(design.columns.values)

    # Check if headers
    logger.info("Running header check.")

    missing_headers = set(design_template) - set(design_headers)

    if len(missing_headers) > 0:
        logger.error('Missing column headers: %s', list(missing_headers))
        raise Exception("Missing column headers: %s" % list(missing_headers))
    
    return design

def main():
    args = get_args()
    design = args.design

    # Create a file handler
    handler = logging.FileHandler('design.log')
    logger.addHandler(handler)

    # Read files as dataframes
    design_df = pd.read_csv(args.design, sep=',')

    # Check design file
    new_design_df = check_design_headers(design_df)

    new_design_df.to_csv('design.checked.csv', header=True, sep=',', index=False)

if __name__ == '__main__':
    main()
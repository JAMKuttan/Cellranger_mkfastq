#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os
import glob

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
		'/../output/mkfastq/**/outs/fastq_path/**/**/'

@pytest.mark.mkfastq
def test_mkfastq():
    fastqcs = glob.glob('/../output/mkfastq/*/outs/fastq_path/*/*/*.fastq.gz', recursive=True)
    for f in fastqcs:
        assert os.path.exists(os.path.join(test_output_path, f))

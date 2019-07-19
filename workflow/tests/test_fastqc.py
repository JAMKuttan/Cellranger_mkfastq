#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os
import glob

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
		'/../../test/mkfastq/'

@pytest.mark.fastqc
def test_fastqc_output():
    assert os.path.exists(os.path.join(test_output_path, glob.glob('*.fastq.gz', recursive=True)))

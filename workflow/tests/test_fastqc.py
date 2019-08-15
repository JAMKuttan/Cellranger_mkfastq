#!/usr/bin/env python3
#test_fastq.py
#*
#* --------------------------------------------------------------------------
#* Licensed under MIT (https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/blob/develop/LICENSE)
#* --------------------------------------------------------------------------
#*

import pytest
import pandas as pd
from io import StringIO
import os

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
                '/../output/misc/fastqc/run/'

@pytest.mark.simple1
def test_simple1_fastqc():
    assert os.path.exists(os.path.join(test_output_path, 'cellranger-tiny-bcl-1_2_0'))

@pytest.mark.simple2
def test_simple2_fastqc():
    assert os.path.exists(os.path.join(test_output_path, 'cellranger-tiny-bcl-1_2_0-1'))
    assert os.path.exists(os.path.join(test_output_path, 'cellranger-tiny-bcl-1_2_0-2'))
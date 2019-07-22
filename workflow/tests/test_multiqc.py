#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
                '/../output/multiqc/run/'

@pytest.mark.simple1
def test_simple1_multiqc():
    assert os.path.exists(os.path.join(test_output_path, 'multiqc_report.html'))

@pytest.mark.simple2
def test_simple2_multiqc():
    assert os.path.exists(os.path.join(test_output_path, 'multiqc_report.html'))

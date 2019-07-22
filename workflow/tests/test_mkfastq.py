#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
		'/../output/mkfastq/'

@pytest.mark.simple1
def test_simple1_mkfastq():
    assert os.path.exists(os.path.join(test_output_path, 'cellranger-tiny-bcl-1_2_0', 'outs'))

@pytest.mark.simple2
def test_simple2_mkfastq():
    assert os.path.exists(os.path.join(test_output_path, 'cellranger-tiny-bcl-1_2_0-1', 'outs'))
    assert os.path.exists(os.path.join(test_output_path, 'cellranger-tiny-bcl-1_2_0-2', 'outs'))

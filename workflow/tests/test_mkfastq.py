#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os
import glob

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
		'/../output/mkfastq/cellranger-tiny-bcl-1_2_0/outs/'

@pytest.mark.mkfastq
def test_mkfastq():
    assert os.path.exists(test_output_path)

#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
                '/../output/misc/fastqc/run/cellranger-tiny-bcl-1_2_0/'

@pytest.mark.fastqc
def test_fastqc():
    assert os.path.exists(test_output_path)

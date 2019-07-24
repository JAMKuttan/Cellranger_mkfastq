#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
                '/../output/untarBCL/'

@pytest.mark.simple1
def test_simple1_untarBCL():
    assert os.path.exists(os.path.join(test_output_path, 'cellranger-tiny-bcl-1_2_0', 'RTAComplete.txt'))

@pytest.mark.simple2
def test_simple2_untarBCL():
    assert os.path.exists(os.path.join(test_output_path, 'cellranger-tiny-bcl-1_2_0-1', 'RTAComplete.txt'))
    assert os.path.exists(os.path.join(test_output_path, 'cellranger-tiny-bcl-1_2_0-2', 'RTAComplete.txt'))

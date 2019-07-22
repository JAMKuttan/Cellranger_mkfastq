#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
                '/../output/untarBCL/cellranger-tiny-bcl-1_2_0/'

@pytest.mark.untarBCL
def test_untarBCL():
    assert os.path.exists(os.path.join(test_output_path, 'RTAComplete.txt'))

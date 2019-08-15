#!/usr/bin/env python3
#test_check_design.py
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
                '/../output/misc/checkDesignFile/run/'

@pytest.mark.simple1
def test_simple1_design():
    assert os.path.exists(os.path.join(test_output_path, 'design.checked.csv'))

@pytest.mark.simple2
def test_simple2_design():
    assert os.path.exists(os.path.join(test_output_path, 'design.checked.csv'))    
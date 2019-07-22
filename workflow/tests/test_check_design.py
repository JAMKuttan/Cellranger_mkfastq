#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
                '/../output/misc/checkDesignFile/**/'

@pytest.mark.design
def test_design():
    design_file = os.path.join(test_output_path, 'design.checked.csv')
    print(design_file)
    assert os.path.exists(design_file)

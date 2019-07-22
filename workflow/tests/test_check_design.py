#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
                '/../../test/misc/checkDesignFile/**/'

@pytest.mark.design
def test_design():
    assert os.path.exists(os.path.join(test_output_path, design.checked.csv))

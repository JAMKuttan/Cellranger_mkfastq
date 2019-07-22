#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
                '/../output/misc/versions/run/'

@pytest.mark.simple1
def test_simple1_versions():
    assert os.path.exists(os.path.join(test_output_path, 'versions_mqc.yaml'))
    assert os.path.exists(os.path.join(test_output_path, 'references_mqc.yaml'))

@pytest.mark.simple2
def test_simple2_versions():
    assert os.path.exists(os.path.join(test_output_path, 'versions_mqc.yaml'))
    assert os.path.exists(os.path.join(test_output_path, 'references_mqc.yaml'))

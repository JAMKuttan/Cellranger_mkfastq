#!/usr/bin/env python3

import pytest
import pandas as pd
from io import StringIO
import os

test_output_path = os.path.dirname(os.path.abspath(__file__)) + \
                '/../../test/misc/fastqc/**/**/'

@pytest.mark.fastqc
def test_fastqc():
    fastqcs = glob.glob('/../../test/misc/fastqc/*/*/*fastqc.zip', recursive=True)
    for f in fastqcs:
        assert os.path.exists(os.path.join(test_output_path, f))

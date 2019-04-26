#!/bin/bash

fastqc --version | grep 'FastQC v' | sed -n -e 's/^FastQC v//p' > version_fastqc.txt  

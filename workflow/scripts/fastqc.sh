#!/bin/bash

find . -name '*.fastq.gz' | awk '{printf("fastqc \"%s\"\n", $0)}' | parallel -j 25 --verbose
#find . -name '*fastqc.*' | xargs -I '{}' mv '{}' ./

fastqc --version |& grep 'FastQC v' | sed -n -e 's/^FastQC v//p' > version_fastqc.txt  

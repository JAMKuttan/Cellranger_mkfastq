#!/bin/bash

find . -name '*.fastq.gz' | awk '{printf("fastqc \"%s\"\n", $0)}' | parallel -j 25 --verbose
#find . -name '*fastqc.*' | xargs -I '{}' mv '{}' ./

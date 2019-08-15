#!/bin/bash
#fastqc.sh
#*
#* --------------------------------------------------------------------------
#* Licensed under MIT (https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/blob/develop/LICENSE)
#* --------------------------------------------------------------------------
#*

find . -name '*.fastq.gz' | awk '{printf("fastqc \"%s\"\n", $0)}' | parallel -j $(grep -c ^processor /proc/cpuinfo) --verbose
#find . -name '*fastqc.*' | xargs -I '{}' mv '{}' ./ 
#for i in `ls *.fastq.gz`;
#do echo "fastqc ${i}";
#done | parallel -j `grep -c ^processor /proc/cpuinfo` --verbose;

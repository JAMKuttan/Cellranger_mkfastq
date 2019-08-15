#!/bin/bash
#fastqc.sh
#*
#* --------------------------------------------------------------------------
#* Licensed under MIT (https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/blob/develop/LICENSE)
#* --------------------------------------------------------------------------
#*

find . -name '*.fastq.gz' | awk '{printf("fastqc \"%s\"\n", $0)}' | parallel -j $(grep -c ^processor /proc/cpuinfo) --verbose
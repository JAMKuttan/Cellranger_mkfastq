#!/bin/bash
#versions_mkfastq.sh
#*
#* --------------------------------------------------------------------------
#* Licensed under MIT (https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/blob/develop/LICENSE)
#* --------------------------------------------------------------------------
#*

cellranger mkfastq --version | grep 'cellranger mkfastq ' | sed 's/.*(\(.*\))/\1/' > version_cellranger.mkfastq.txt
bcl2fastq --version |& grep 'bcl2fastq v' | sed -n -e 's/^bcl2fastq v//p' > version_bcl2fastq.txt  

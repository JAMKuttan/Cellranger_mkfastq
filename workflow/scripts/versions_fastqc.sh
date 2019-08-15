#!/bin/bash
#versions_fastqc.sh
#*
#* --------------------------------------------------------------------------
#* Licensed under MIT (https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/blob/develop/LICENSE)
#* --------------------------------------------------------------------------
#*

fastqc --version | grep 'FastQC v' | sed -n -e 's/^FastQC v//p' > version_fastqc.txt  
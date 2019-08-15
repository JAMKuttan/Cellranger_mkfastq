#!/bin/bash
#countDesign.sh
#*
#* --------------------------------------------------------------------------
#* Licensed under MIT (https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/blob/develop/LICENSE)
#* --------------------------------------------------------------------------
#*


fastqs=($(ls *.fastq.gz))
design=$(ls *.csv)
sample=$(cat ${design} | tail -n +2 | cut -d ',' -f2)

echo "Sample,fastq_R1,fastq_R2" > Cellranger_Count_Design.csv;

for i in ${sample};
do
  for j in $(seq 1 ${#fastqs[@]});
  do
    if [[ ${fastqs[${j}-1]} == *_I* ]]; then
      continue
    elif [[ ${fastqs[${j}-1]} == *${i}* && ${fastqs[${j}]} == *${i}* ]]; then
      echo "${i},${fastqs[${j}-1]},${fastqs[${j}]}" >> Cellranger_Count_Design.csv
    fi
  done
done

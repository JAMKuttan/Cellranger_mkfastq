#!/bin/bash
#countDesign.sh

fastqs=$(ls *.fastq.gz)
design=$(ls *.csv)
sample=$(cat ${design} | tail -n +2 | cut -d ',' -f2)

for i in ${fastqs};
do
  if [[ ${i} == *_S0_* ]]; then
    continue
  elif [[ ${i} == *_I* ]]; then
    continue
  else
    good=(${good[@]} ${i})
  fi
done

echo "Sample,fastq_R1,fastq_R2" > Cellranger_Count_Design.csv;
echo "${sample},${good[0]},${good[1]}" >> Cellranger_Count_Design.csv;

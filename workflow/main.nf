#!/usr/bin/env nextflow

// Path to an input file, or a pattern for multiple inputs
// Note - $baseDir is the location of this workflow file main.nf

// Define Input variables
params.bcl = "$baseDir/../test_data/*.tar.gz"
params.designFile = "$baseDir/../test_data/design.csv"
params.outDir = "$baseDir/output"

// Define List of Files
tarList = Channel.fromPath( params.bcl )

// Define regular variables
designLocation = Channel
  .fromPath(params.designFile)
  .ifEmpty { exit 1, "design file not found: ${params.designFile}" }
outDir = params.outDir

process checkDesignFile {

  publishDir "$outDir/${task.process}", mode: 'copy'

  input:

  file designLocation

  output:

  file("design.checked.csv") into designPaths

  script:

  """
  hostname
  ulimit -a
  module load python/3.6.1-2-anaconda
  python3 $baseDir/scripts/check_design.py -d $designLocation
  """
}


process untarBCL {
  tag "$tar"

  publishDir "$outDir/${task.process}", mode: 'copy'

  input:

  file tar from tarList

  output:

  file("*") into bclPaths

  script:

  """
  hostname
  ulimit -a
  name=`echo ${tar} | rev | cut -f1 -d '.' | rev`;
  if [ "\${name}" == "gz" ];
  then   module load pigz/2.4;
  tar -xvf $tar -I pigz;
  else tar -xvf ${tar};
  fi;
  """
}

process mkfastq {
  tag "${bcl.baseName}"
  queue '128GB,256GB,256GBv1,384GB'

  publishDir "$outDir/${task.process}", mode: 'copy'

  input:

  val bcl from bclPaths
  file designPaths

  output:

  file("**/outs/fastq_path/**/*") into mkfastqPaths
  file("**/outs/**/*.fastq.gz") into fastqPaths
  file("**/outs/fastq_path/Stats/Stats.json") into bqcPaths

  script:

  """
  hostname
  ulimit -a
  module load cellranger/3.0.2
  module load bcl2fastq/2.19.1
  cellranger mkfastq --id="${bcl.baseName}" --run=$bcl --csv=$designPaths -r \$SLURM_CPUS_ON_NODE  -p \$SLURM_CPUS_ON_NODE  -w \$SLURM_CPUS_ON_NODE 
  """
}


process fastqc {
  publishDir "$outDir/${task.process}", mode: 'copy'

  input:
  file fastqPaths

  output:

  file("*fastqc.*") into fqcPaths

  script:

  """
  hostname
  ulimit -a
  module load fastqc/0.11.5
  module load parallel
  sh $baseDir/scripts/fastqc.sh
  """
}


process multiqc {
  publishDir "$outDir/${task.process}", mode: 'copy'

  input:

  file bqcPaths
  file fqcPaths

  output:

  file("*") into mqcPaths

  script:

  """
  hostname
  ulimit -a
  module load multiqc/1.7
  multiqc .
  """
}

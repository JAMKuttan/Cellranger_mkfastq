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
  module load pigz/2.4
  tar -xvf $tar -I pigz
  """
}


process mkfastq {
  tag "${bcl.baseName}"

  publishDir "$outDir/${task.process}", mode: 'copy'

  input:

  val bcl from bclPaths
  file designPaths

  output:

  file("**/outs/fastq_path/**/*") into fastqPaths

  script:

  """
  hostname
  ulimit -a
  module load cellranger/3.0.2
  module load bcl2fastq/2.19.1
  cellranger mkfastq --nopreflight --id="${bcl.baseName}" --run=$bcl --csv=$designPaths -r \$SLURM_CPUS_ON_NODE  -p \$SLURM_CPUS_ON_NODE  -w \$SLURM_CPUS_ON_NODE 
  """
}

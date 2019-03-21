#!/usr/bin/env nextflow

// Path to an input file, or a pattern for multiple inputs
// Note - $baseDir is the location of this workflow file main.nf

// Define Input variables
params.bcl = "$baseDir/../test_data/*.tar.gz"
params.designFile = "$baseDir/../test_data/design.csv"


// Define List of Files
tarList = Channel.fromPath( params.bcl )


// Define regular variables


process checkDesignFile {

  publishDir "$baseDir/output/design", mode: 'copy'

  input:

  params.designFile

  output:

  file("design.csv") into designPaths

  script:

  """
  module load python/3.6.1-2-anaconda
  python3 $baseDir/scripts/check_design.py -d $params.designFile
  """
}


process untarBCL {
  tag "$tar"

  publishDir "$baseDir/output/bcl", mode: 'copy'

  input:

  file tar from tarList

  output:

  file("*") into bclPaths

  script:

  """
  module load pigz/2.4
  tar -xvf $tar -I pigz
  """
}


process mkfastq {

  tag "${bcl.baseName}"
  publishDir "$baseDir/output/fastq/${bcl.baseName}", mode: 'copy'

  input:

  val bcl from bclPaths
  file designPaths

  output:

  file("**/outs/fastq_path/**/*") into fastqPaths

  script:

  """
  module load cellranger/2.1.1
  module load bcl2fastq/2.17.1.14
  cellranger mkfastq --id="${bcl.baseName}" --run=$bcl --csv=$designPaths
  """
}

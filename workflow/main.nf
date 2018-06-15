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
  python $baseDir/scripts/check_design.py -d $params.designFile
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

  tar -xvf $tar
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
  cellranger mkfastq --id="${bcl.baseName}" --run=$bcl --csv=$designPaths
  """
}

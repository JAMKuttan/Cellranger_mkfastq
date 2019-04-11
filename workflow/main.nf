#!/usr/bin/env nextflow

// Path to an input file, or a pattern for multiple inputs
// Note - $baseDir is the location of this workflow file main.nf

// Define Input variables
params.name = "small"
params.bcl = "$baseDir/../test_data/*.tar.gz"
params.designFile = "$baseDir/../test_data/design.csv"
params.outDir = "$baseDir/output"

// Define List of Files
tarList = Channel.fromPath( params.bcl )

// Define regular variables
name = params.name
designLocation = Channel
  .fromPath(params.designFile)
  .ifEmpty { exit 1, "design file not found: ${params.designFile}" }
outDir = params.outDir

process checkDesignFile {
  tag "$name"
  publishDir "$outDir/misc/${task.process}/$name", mode: 'copy'

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
  file("version*.txt") into versionPaths_mkfastq

  script:

  """
  hostname
  ulimit -a
  module load cellranger/3.0.2
  module load bcl2fastq/2.19.1
  sh $baseDir/scripts/versions_mkfastq.sh
  cellranger mkfastq --id="${bcl.baseName}" --run=$bcl --csv=$designPaths -r \$SLURM_CPUS_ON_NODE  -p \$SLURM_CPUS_ON_NODE  -w \$SLURM_CPUS_ON_NODE 
  """
}


process fastqc {
  tag "$name"
  queue 'super'
  publishDir "$outDir/misc/${task.process}/$name", mode: 'copy'

  input:
  file fastqPaths

  output:

  file("*fastqc.*") into fqcPaths
  file("version*.txt") into versionPaths_fastqc

  script:

  """
  hostname
  ulimit -a
  module load fastqc/0.11.5
  module load parallel
  sh $baseDir/scripts/fastqc.sh
  """
}


process versions {
  tag "$name"
  publishDir "$outDir/misc/${task.process}/$name", mode: 'copy'

  input:

  file versionPaths_mkfastq
  file versionPaths_fastqc

  output:

  file("*.yaml") into yamlPaths

  script:

  """
  hostname
  ulimit -a
  module load python/3.6.1-2-anaconda
  echo $workflow.nextflow.version > version_nextflow.txt
  python3 $baseDir/scripts/generate_versions.py -f version_*.txt -o versions
  """
}


process multiqc {
  tag "$name"
  queue 'super'
  publishDir "$outDir/${task.process}/$name", mode: 'copy'

  input:

  file bqcPaths
  file fqcPaths
  file yamlPaths

  output:

  file("*") into mqcPaths

  script:

  """
  hostname
  ulimit -a
  module load multiqc/1.7
  multiqc . -c $baseDir/scripts/.multiqc_config.yaml 
  """
}

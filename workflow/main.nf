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
  module 'python/3.6.1-2-anaconda'

  input:

  file designLocation

  output:

  file("design.checked.csv") into designPaths

  script:

  """
  hostname
  ulimit -a
  python3 $baseDir/scripts/check_design.py -d $designLocation
  """
}


process untarBCL {
  tag "$tar"
  publishDir "$outDir/${task.process}", mode: 'copy'
  module 'pigz/2.4'

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
  then tar -xvf ${tar} -I pigz;
  rm \${name};
  else tar -xvf ${tar};
  fi;
  """
}

process mkfastq {
  tag "${bcl.baseName}"
  queue '128GB,256GB,256GBv1,384GB'
  publishDir "$outDir/${task.process}", mode: 'copy', pattern: "{*.fastq.gz,Stats.json}"
  module 'cellranger/3.0.2:bcl2fastq/2.19.1'

  input:

  val bcl from bclPaths
  file designPaths

  output:

  file("**/outs/**/*.fastq.gz") into fastqPaths
  file("**/outs/fastq_path/Stats/Stats.json") into bqcPaths
  file("version*.txt") into versionPaths_mkfastq

  script:

  """
  hostname
  ulimit -a
  sh $baseDir/scripts/versions_mkfastq.sh
  cellranger mkfastq --id="${bcl.baseName}" --run=$bcl --csv=$designPaths -r \$SLURM_CPUS_ON_NODE  -p \$SLURM_CPUS_ON_NODE  -w \$SLURM_CPUS_ON_NODE 
  """
}


process fastqc {
  tag "$name"
  queue 'super'
  publishDir "$outDir/misc/${task.process}/$name", mode: 'copy'
  module 'fastqc/0.11.5'

  input:
  file fastqPaths

  output:

  file("*fastqc.zip") into fqcPaths
  file("version*.txt") into versionPaths_fastqc

  script:

  """
  hostname
  ulimit -a
  bash $baseDir/scripts/fastqc.sh
  """
}


process versions {
  tag "$name"
  publishDir "$outDir/misc/${task.process}/$name", mode: 'copy'
  module 'python/3.6.1-2-anaconda'

  input:

  file versionPaths_mkfastq
  file versionPaths_fastqc

  output:

  file("*.yaml") into yamlPaths

  script:

  """
  hostname
  ulimit -a
  echo $workflow.nextflow.version > version_nextflow.txt
  python3 $baseDir/scripts/generate_versions.py -f version_*.txt -o versions
  """
}


process multiqc {
  tag "$name"
  queue 'super'
  publishDir "$outDir/${task.process}/$name", mode: 'copy'
  module 'multiqc/1.7'

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
  multiqc *fastqc.zip -c $baseDir/scripts/.multiqc_config.yaml 
  """
}

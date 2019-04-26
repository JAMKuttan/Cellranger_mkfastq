#!/usr/bin/env nextflow

// Path to an input file, or a pattern for multiple inputs
// Note - $baseDir is the location of this workflow file main.nf

// Define Input variables
params.name = "run"
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
  python3 "$baseDir/scripts/check_design.py" -d "$designLocation"
  """
}


process untarBCL {
  tag "$tar"
  publishDir "$outDir/${task.process}", mode: 'copy'
  module 'pigz/2.4'

  input:

  file tar from tarList

  output:

  file("*") into bclPaths mode flatten

  script:

  """
  hostname
  ulimit -a
  name=`echo ${tar} | rev | cut -f1 -d '.' | rev`;
  if [ "\${name}" == "gz" ];
  then tar -xvf "$tar" -I pigz;
  else tar -xvf "$tar";
  fi;
  """
}


process mkfastq {
  tag "${bcl.baseName}"
  queue '128GB,256GB,256GBv1,384GB'
  publishDir "$outDir/${task.process}", mode: 'copy', pattern: "{*/outs/**/*.fastq.gz}"
  module 'cellranger/3.0.2:bcl2fastq/2.19.1'

  input:

  each bcl from bclPaths.collect()
  file design from designPaths

  output:

  file("**/outs/**/*.fastq.gz") into fastqPaths
  file("**/outs/fastq_path/Stats/Stats.json") into bqcPaths
  val "${bcl.baseName}" into bclName

  script:

  """
  hostname
  ulimit -a
  cellranger mkfastq --id="${bcl.baseName}" --run="$bcl" --csv=$design -r \$SLURM_CPUS_ON_NODE  -p \$SLURM_CPUS_ON_NODE  -w \$SLURM_CPUS_ON_NODE 
  """
}

process fastqc {
  tag "$bclName"
  queue 'super'
  publishDir "$outDir/misc/${task.process}/$name/$bclName", mode: 'copy', pattern: "{*fastqc.zip}"
  module 'fastqc/0.11.5:parallel'

  input:
  file fastqPaths
  val bclName

  output:

  file("*fastqc.zip") into fqcPaths

  script:

  """
  hostname
  ulimit -a
  find *.fastq.gz -exec mv {} $bclName.{} \\;
  bash "$baseDir/scripts/fastqc.sh"
  
  """
}


process versions {
  tag "$name"
  publishDir "$outDir/misc/${task.process}/$name", mode: 'copy'
  module 'python/3.6.1-2-anaconda:cellranger/3.0.2:bcl2fastq/2.19.1:fastqc/0.11.5'

  input:

  output:

  file("*.yaml") into yamlPaths

  script:

  """
  hostname
  ulimit -a
  echo $workflow.nextflow.version > version_nextflow.txt
  bash "$baseDir/scripts/versions_mkfastq.sh"
  bash "$baseDir/scripts/versions_fastqc.sh"
  python3 "$baseDir/scripts/generate_versions.py" -f version_*.txt -o versions
  """
}

process multiqc {
  tag "$name"
  queue 'super'
  publishDir "$outDir/${task.process}/$name", mode: 'copy', pattern: "{multiqc*}"
  module 'multiqc/1.7'

  input:

  file bqc name "bqc/?/*" from bqcPaths.collect()
  file fqc name "fqc/*" from fqcPaths.collect()
  file yamlPaths

  output:

  file("*") into mqcPaths

  script:

  """
  hostname
  ulimit -a
  multiqc . -c "$baseDir/conf/multiqc_config.yaml"
  """
}

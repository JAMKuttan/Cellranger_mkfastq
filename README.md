|*master*|*develop*|
|:-:|:-:|
|[![Build Status](https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/badges/master/build.svg)](https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/commits/master)|[![Build Status](https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/badges/develop/build.svg)](https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/commits/develop)|

10x Genomics scRNA-Seq (cellranger) mkfastq Pipeline
==================================================

Introduction
------------

This pipeline is a wrapper for the cellranger mkfastq tool from 10x Genomics. It takes demultiplexes samples from 10x Genomics Single Cell Gene Expression libraries into fastqs.

The pipeline uses Nextflow, a bioinformatics workflow tool.

This pipeline is primarily used with a SLURM cluster on the BioHPC Cluster. However, the pipeline should be able to run on any system that Nextflow supports.

Additionally, the pipeline is designed to work with Astrocyte Workflow System using a simple web interface.

To Run:
-------

* Available parameters:
  * **--name**
        * run name, puts outputs in a directory with this name
        * eg: **--name 'test'**
  * **--bcl**
        * Base call files (tarballed [*.tar] +/- gunzipping [*.tar.gz] from a sequencing of 10x single-cell expereiment, supports pigr parallelization).
        * There can be multiple basecall files, but they all will be demultiplexed by the same design file.
        * eg: **--bcl '/project/shared/bicf_workflow_ref/workflow_testdata/cellranger/cellranger_mkfastq/simple/cellranger-tiny-bcl-simple-1_2_0.tar.gz'**
  * **--designFile**
        * path to design file (csv format) location
        * column 1 = "Lane" (number of lanes to demultiplex, */** for all lanes)
        * column 2 = "Sample" (sample name)
        * column 3 = "Index" (10x sample index barcode, eg SI-GA-A1)
        * can have repeated "Sample" if there are multiple fastq R1/R2 pairs for the samples
        * eg: **--designFile '/project/shared/bicf_workflow_ref/workflow_testdata/cellranger/cellranger_mkfastq/simple/cellranger-tiny-bcl-simple-1_2_0.csv'**
    * **--outDir**
        * optional output directory for run
        * eg: **--outDir 'test'**
    * FULL EXAMPLE:

**nextflow run workflow/main.nf --name 'test' --bcl '/project/shared/bicf_workflow_ref/workflow_testdata/cellranger/cellranger_mkfastq/simple/cellranger-tiny-bcl-simple-1_2_0.tar.gz' --designFile '/project/shared/bicf_workflow_ref/workflow_testdata/cellranger/cellranger_mkfastq/simple/cellranger-tiny-bcl-simple-1_2_0.csv' --outDir 'test'**

* Design example:

| Lane | Sample      | Index     |
|------|-------------|-----------|
| *    | test_sample | SI-P03-C9 |

|*master*|*develop*|
|:-:|:-:|
|[![Build Status](https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/badges/master/build.svg)](https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/commits/master)|[![Build Status](https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/badges/develop/build.svg)](https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/commits/develop)|

10x Genomics scRNA-Seq (cellranger) mkfastq Pipeline
========================================

Introduction
------------

This pipeline is a wrapper for the cellranger mkfastq tool from 10x Genomics. It takes bcl files from sequencing of 10x Genomics Single Cell Gene Expression libraries, and deconvolutles the reads by the samples' barcodes.

The pipeline uses Nextflow, a bioinformatics workflow tool.

This pipeline is primarily used with a SLURM cluster on the BioHPC Cluster. However, the pipeline should be able to run on any system that Nextflow supports.

Additionally, the pipeline is designed to work with Astrocyte Workflow System using a simple web interface.

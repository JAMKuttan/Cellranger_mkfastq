10x Genomics scRNA-Seq (cellranger) mkfastq Pipeline
========================================

Introduction
------------

This pipeline is a wrapper for the cellranger mkfastq tool from 10x Genomics, which is a wrapper for Illumina's bcl2fastq tool. It takes tarballed bcl files from 10x Genomics Single Cell Gene Expression libraries, and untar's and deconvolves them into fastq's.

The pipeline uses Nextflow, a bioinformatics workflow tool.

This pipeline is primarily used with a SLURM cluster on the BioHPC Cluster. However, the pipeline should be able to run on any system that Nextflow supports.

Additionally, the pipeline is designed to work with Astrocyte Workflow System using a simple web interface.
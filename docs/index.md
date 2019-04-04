10x Genomics scRNA-Seq (cellranger) mkfastq Pipeline
====================================================

Introduction
------------

This pipeline is a wrapper for the cellranger count tool from 10x Genomics. It takes fastq files from 10x Genomics Single Cell Gene Expression libraries, performs alignment, filtering, barcode counting, and UMI counting. It uses the Chromium cellular barcodes to generate gene-barcode matrices, determine clusters, and perform gene expression analysis.

The pipeline uses Nextflow, a bioinformatics workflow tool.





Credits
-------
This worklow is was developed jointly with the [Bioinformatic Core Facility (BICF), Department of Bioinformatics](http://www.utsouthwestern.edu/labs/bioinformatics/)


Please cite in publications: Pipeline was developed by BICF from funding provided by **Cancer Prevention and Research Institute of Texas (RP150596)**.

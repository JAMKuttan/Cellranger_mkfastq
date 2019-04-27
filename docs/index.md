10x Genomics scRNA-Seq (cellranger) mkfastq Pipeline
====================================================

Introduction
------------

This pipeline is a wrapper for the cellranger mkfastq tool from 10x Genomics (which uses Illumina's bcl2fastq). It takes demultiplexes samples from 10x Genomics Single Cell Gene Expression libraries into fastqs.

FastQC is run on the resulting fastq and those reports and bcl2fastq reports are collated with the MultiQC tool.

The pipeline uses Nextflow, a bioinformatics workflow tool.

To Run:
-------

* Workflow parameters:
  * **bcl**
    * Base call files (tarballed [*.tar] +/- gunzipping [*.tar.gz] from a sequencing of 10x single-cell expereiment, supports pigr parallelization).
    * There can be multiple basecall files, but they all will be demultiplexed by the same design file.
    * REQUIRED
  * **design file**
    * A design file listing lane, sample, corresponding sample barcode. There can be multiple rows with the same sample name, if there are multiple fastq's for that sample.
    * REQUIRED
    * column 1 = "Lane" (number of lanes to demultiplex, */** for all lanes)
    * column 2 = "Sample" (sample name)
    * column 3 = "Index" (10x sample index barcode, eg SI-GA-A1)
    * eg: can be downloaded [HERE](https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/blob/master/docs/design.csv)


* Design example:

    | Lane | Sample      | Index     |
    |------|-------------|-----------|
    | *    | test_sample | SI-P03-C9 |
    


[**CHANGELOG**](https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/blob/master/CHANGELOG.md)

Credits
-------
This worklow is was developed jointly with the [Bioinformatic Core Facility (BICF), Department of Bioinformatics](http://www.utsouthwestern.edu/labs/bioinformatics/)


Please cite in publications: Pipeline was developed by BICF from funding provided by **Cancer Prevention and Research Institute of Texas (RP150596)**.

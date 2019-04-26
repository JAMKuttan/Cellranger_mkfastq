# v1.1.1
### User Facing
* Fix design file not visible in Astrocyte
* Fix handling of multiple flowcells in 1 submission
### Background
* Move multiqc config to conf folder
* Add CI test for multiple flowcells
* Add changelog
* Quote design/tarball/$baseDir path in processes in case of spaces
### *Known Bugs*
* cellranger mkfastq will not accept spaces in path for run param even if quoted, issue raised on 10XGenomics/cellranger github issue [#31](https://github.com/10XGenomics/cellranger/issues/31)
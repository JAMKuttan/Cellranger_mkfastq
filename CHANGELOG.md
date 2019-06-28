# v1.2.0 (in development)
**User Facing**
* Add references to of tools to mutiQC report
* Add BICF details to multiqc report

**Background**
* Add DOI (develop branch)
* Add changelog as link to astrocyte docs (master branch)
* Update example design file link in astrocyte docs (master branch)
* Check tarballed bcl directory for spaces and exit if it contains one...cellranger mkfastq cannot handle spaces (develop branch)
* Move untar (including space check) to bash script
* Add Jeremy Mathews to author list

*Known Bugs*
* cellranger mkfastq will not accept spaces in path for run param even if quoted, issue raised on 10XGenomics/cellranger github issue [#31](https://github.com/10XGenomics/cellranger/issues/31)
  note: 10x doesn't check github issues, emailed instead
  note: pipeline checks for spaces and exits prematurely if found

# v1.1.4
**User Facing**
* Fix design file not visible in Astrocyte
* Fix handling of multiple flowcells in 1 submission

**Background**
* Move multiqc config to conf folder
* Add CI test for multiple flowcells
* Add changelog
* Quote design/tarball/$baseDir path in processes in case of spaces

*Known Bugs*
* cellranger mkfastq will not accept spaces in path for run param even if quoted, issue raised on 10XGenomics/cellranger github issue [#31](https://github.com/10XGenomics/cellranger/issues/31)

# v1.3.1 (in development)
**User Facing**

**Background**
* Add multiqc output to atrifacts

*Known Bugs*
* cellranger mkfastq will not accept spaces in path for run param even if quoted, issue raised on 10XGenomics/cellranger github issue [#31](https://github.com/10XGenomics/cellranger/issues/31)
    * note: 10x doesn't check github issues, emailed instead
    * note: pipeline checks for spaces and exits prematurely if found
* If multiple flowcells (tar'd) files are inputted then there will be multiple fastq's by the same name, currently dealing with that name conflict is not tractable
    * note: if multiple bcl files are detected then cellranger_count design file is not created

# v1.3.0
**User Facing**
* Change Cellranger Version to 3.1.0
* Fix countDesign to take multiple samples
* Add MIT License

**Background**
* Add CI artifacts

*Known Bugs*
* cellranger mkfastq will not accept spaces in path for run param even if quoted, issue raised on 10XGenomics/cellranger github issue [#31](https://github.com/10XGenomics/cellranger/issues/31)
    * note: 10x doesn't check github issues, emailed instead
    * note: pipeline checks for spaces and exits prematurely if found
* If multiple flowcells (tar'd) files are inputted then there will be multiple fastq's by the same name, currently dealing with that name conflict is not tractable
    * note: if multiple bcl files are detected then cellranger_count design file is not created

# v1.2.0
**User Facing**
* Add references to of tools to mutiQC report
* Add BICF details to multiqc report
* Create cellranger_count design file (if only 1 flowcell is inputted)

**Background**
* Add DOI (develop branch)
* Add changelog as link to astrocyte docs (master branch)
* Update example design file link in astrocyte docs (master branch)
* Check tarballed bcl directory for spaces and exit if it contains one...cellranger mkfastq cannot handle spaces (develop branch)
* Move untar (including space check) to bash script
* Add Jeremy Mathews to author list
* Apply style guide
* Add pytests for ouptuts

*Known Bugs*
* cellranger mkfastq will not accept spaces in path for run param even if quoted, issue raised on 10XGenomics/cellranger github issue [#31](https://github.com/10XGenomics/cellranger/issues/31)
    * note: 10x doesn't check github issues, emailed instead
    * note: pipeline checks for spaces and exits prematurely if found
* If multiple flowcells (tar'd) files are inputted then there will be multiple fastq's by the same name, currently dealing with that name conflict is not tractable
    * note: if multiple bcl files are detected then cellranger_count design file is not created

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

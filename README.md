# TelomereHunter
This repo consists of the nextflow pipeline for telomere hunter tool.

## MAMBA ENVIRONMENT:
- Create a new mamba environment and installing tools needed for the pipeline
```
mamba create -n telomere_test python=2.7  r=3.3
pip install telomerehunter
mamba install bioconda::samtools
mamba install bioconda::nextflow

#-- env file not working --#
mamba env create -n telomere_test -f env.yaml
```
## HOW TO RUN THE PIPELINE:
- INPUTS:
Script name: run_telomere_pipeline
    - sample_sheet  =</path/of/the/sample_sheet.csv>
    - project       = "MSK" or "TCGA"
    - out_dir       =</path/of/the/directory/to/store/results>

Note: pipeline is sensitive for the  sample sheet columns names
MSK     : PATIENT_ID, BAM_PATH, BAM_PATH_TO_NORMALS
TCGA    : PATIENT_ID, TUMOR_BAM, NORMAL_BAM

- PARAMETERS:
Script name: nextflow.config
    - plotNone    = No R plots 
 
- COMMAND:

  Change all the required parameters in the bash script and run the following command

  ```
  bash run_telomere_pipeline.sh
  ```

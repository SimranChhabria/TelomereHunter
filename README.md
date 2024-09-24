# TelomereHunter
This repo consists of the nextflow pipeline for telomere hunter tool.

## MAMBA ENVIRONMENT:
- Create a new mamba environment and installing tools needed for the pipeline
```
mamba env create -n telomere_test -f env.yaml
```
## HOW TO RUN THE PIPELINE:
- INPUTS:
Script name: run_telomere_pipeline
    - input_reads   =</path/of/the/directory/containing/bam/files>
    - output_dir    =</path/of/the/directory/to/store/results>

- PARAMETERS:
Script name: nextflow.config
    - plotNone    = No R plots 
 
- COMMAND:

  Change all the required parameters in the bash script and run the following command

  ```
  bash run_telomere_pipeline.sh
  ```

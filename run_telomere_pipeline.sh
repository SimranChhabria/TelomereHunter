#!/bin/bash
#BSUB -J nextflow_telomerehunter
#BSUB -W 48:00
#BSUB -n 1
#BSUB -C 0
#BSUB -o nextflow_telomerehunter_%J.stdout
#BSUB -eo nextflow_telomerehunter_%J.stderr

source ~/.bashrc
mamba activate telomere_test

# Set the input and output directory paths
input_bam="/data/morrisq/simranch/ALT/TelomereHunter/test_bams/*{T,N}*bam"
out_dir="/data/morrisq/simranch/ALT/TelomereHunter/test_bams/nextflow_test"

mkdir -p $out_dir

nextflow run main_telomere.nf \
         --input_bam $input_bam \
         --out_dir $out_dir \
         -resume
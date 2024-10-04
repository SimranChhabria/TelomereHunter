#!/bin/bash
#BSUB -J nextflow_telomerehunter
#BSUB -W 48:00
#BSUB -n 1
#BSUB -C 0
#BSUB -o nextflow_telomerehunter_%J.stdout
#BSUB -eo nextflow_telomerehunter_%J.stderr

source ~/.bashrc
mamba activate telomere_test4

# Set the input and output directory paths
#input_bam="/data/morrisq/simranch/Telomerehunter/test_bams/*{T,N}*bam"
input_bam="/data/morrisq/simranch/Telomerehunter/test_bams/1234N.recal.bam"
out_dir="/data/morrisq/simranch/Telomerehunter/test_bams/nextflow_test"
sample_sheet="/data/morrisq/simranch/Telomerehunter/test_bams/IMPACT_sample_sheet_57.csv"

mkdir -p $out_dir

nextflow run main_telomere.nf \
         --input_bam $input_bam \
         --out_dir $out_dir \
         --sample_sheet $sample_sheet \
         -resume
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
#input_bam="/data/morrisq/simranch/Telomerehunter/test_bams/*{T,N}*bam"

#--- MSK ----#
#input_bam="/data/morrisq/simranch/Telomerehunter/test_bams/1234N.recal.bam"
#out_dir="/data/morrisq/simranch/Telomerehunter/test_bams/nextflow_test"
#sample_sheet="/data/morrisq/simranch/Telomerehunter/test_bams/IMPACT_sample_sheet_57.csv"

#--- TCGA ---#
input_bam=/data/morrisq/simranch/ALT/TCGA_bams/LGG_bams
out_dir=/data/morrisq/simranch/ALT/TCGA_bams/LGG_bams/Telomere_hunter_3_updated
sample_sheet="/data/morrisq/simranch/ALT/files/TCGA-data/meta-data/data-LGG-formatted_subset.csv"
project="TCGA"
work_dir="$out_dir/work"


mkdir -p $out_dir
cd ${out_dir}
nextflow run /data1/morrisq/chhabrs1/TelomereHunter/main_telomere.nf \
         --input_bam $input_bam \
         --out_dir $out_dir \
         --sample_sheet $sample_sheet \
         --project $project \
         -work-dir $work_dir \
         -resume
#!/bin/bash
#BSUB -J nextflow_telomerehunter
#BSUB -W 48:00
#BSUB -n 2
#BSUB -o logs/Telomere.stdout
#BSUB -eo logs/Telomere.stderr

#----
#-- Submit the job using:
# bsub < run_telomere_pipeline.sh 
# Requirements:
# -- Sample_sheet.csv
# -- Project = "MSK" or "TCGA" 
# -- out_dir = <path/to/output/directory>
#----

source ~/.bashrc
conda activate telomere_test


#--- MSK ----#
#out_dir="/data/morrisq/simranch/Telomerehunter/test_bams/nextflow_test"
#sample_sheet="/data/morrisq/simranch/Telomerehunter/test_bams/IMPACT_sample_sheet_57.csv"

#--- MSK ---#
out_dir="/work/morrisq/simran/Telomerehunter/nextflow_test"
sample_sheet="/home/chhabrs1/ALT/sample_sheet_subset.csv"
project="MSK"
work_dir="$out_dir/work"


mkdir -p $out_dir
cd ${out_dir}
nextflow run /home/chhabrs1/TelomereHunter/main_telomere.nf \
         --out_dir $out_dir \
         --sample_sheet $sample_sheet \
         --project $project \
         -work-dir $work_dir \
         -resume

# Check if Nextflow command was successful
if [ $? -eq 0 ]; then
    echo "Nextflow pipeline completed successfully."
else
    echo "Nextflow pipeline failed."
fi
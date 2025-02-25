#!/bin/bash

source ~/.bashrc
mamba activate telomere_test



#--- TCGA -----#
# input_file="/data/morrisq/simranch/ALT/files/TCGA-data/meta-data/data-LGG.csv"
# output_file="/data/morrisq/simranch/ALT/files/TCGA-data/meta-data/data-LGG-formatted.csv"
# input_dir="/data/morrisq/simranch/ALT/TCGA_bams/LGG_bams"


# python TCGA_sample_sheet.py -i $input_file -o $output_file -d $input_dir

#--- CCDI ---#
# input_file="/data/morrisq/simranch/ALT/files/CCDI-data/meta-data/CCDI-patient-data.csv"
# bam_file="/data/morrisq/simranch/ALT/files/CCDI-data/meta-data/CCDI.csv"
# input_dir="/data/morrisq/simranch/ALT/files/CCDI-data/bams"
# output_file="/data/morrisq/simranch/ALT/files/CCDI-data/meta-data/CCDI-mapped.csv"

# python CCDI_sample_sheet.py -i $input_file -o $output_file -d $input_dir -b $bam_file

#-- Combining tsv files ---#

# input_files=/data/morrisq/simranch/ALT/TCGA_bams/LGG_bams/Telomere_hunter_6/TCGA-HW-7486/TCGA-HW-7486_summary.tsv,/data/morrisq/simranch/ALT/TCGA_bams/LGG_bams/Telomere_hunter_6/TCGA-DU-5874/TCGA-DU-5874_summary.tsv
# output_file="/data/morrisq/simranch/ALT/Telomere_hunter_res/TCGA/LGG_combined.csv"

# python combine_tsv.py -i $input_files -o $output_file 

#-- Combining singleton and summary files ---#


input_files=/data/morrisq/simranch/ALT/TCGA_bams/LGG_bams/Telomere_hunter_4/TCGA-HW-7486/TCGA-HW-7486_summary.tsv
singleton_file=/data/morrisq/simranch/ALT/TCGA_bams/LGG_bams/Telomere_hunter_4/TCGA-HW-7486/TCGA-HW-7486_singletons.tsv
output_file="/data/morrisq/simranch/ALT/Telomere_hunter_res/TCGA/LGG_summary_combined_2.csv"

python combine_summary_singleton.py -i $input_files -s $singleton_file -o $output_file 


input_files="/data/morrisq/simranch/ALT/Telomere_hunter_res/TCGA/LGG_summary_combined_2.csv","/data/morrisq/simranch/ALT/Telomere_hunter_res/TCGA/LGG_summary_combined.csv"
output_file="/data/morrisq/simranch/ALT/Telomere_hunter_res/TCGA/LGG_combined.csv"

python combine_tsv.py -i $input_files -o $output_file 
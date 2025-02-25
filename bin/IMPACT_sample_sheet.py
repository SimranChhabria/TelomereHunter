#!/usr/bin/env python3
#---------------------------------------------------------------------------
#    
#---- * Usage : python bin/IMPACT_sample_sheet.py -i ../ALT/sample_table_57_IMPACT_bam.txt -o ../ALT/sample_sheet_TL.csv
#--------------------------------------------------------------------------
import argparse
import pandas as pd
import os


""" Handle arguments """
parser = argparse.ArgumentParser(
    description="IMPACT sample sheet formatting"
)

parser.add_argument("-i", "--input_file",type=argparse.FileType('r'),
    help="input sample sheet", required=True
)

parser.add_argument("-o", "--output_file", type=argparse.FileType('w'), 
      help="Output file", required=True
      )

args = parser.parse_args()
input_file = args.input_file
output_file = args.output_file


data = pd.read_csv(input_file, delimiter='\t')
data.rename(columns={'BAM_PATH': 'TUMOR_BAM'}, inplace=True)
data.rename(columns={'BAM_PATH_TO_NORMALS': 'NORMAL_BAM'}, inplace=True)
subset_data = data.loc[:, ['PATIENT_ID', 'TUMOR_BAM', 'NORMAL_BAM']]

# Save the new DataFrame to a CSV file
subset_data.to_csv(output_file, index=False)




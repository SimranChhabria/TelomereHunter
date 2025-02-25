#!/usr/bin/env python3
#---------------------------------------------------------------------------
#    
#---- * Usage : python3 TCGA_sample_sheet.py -i {input_file} -o {output_file} -d {directory_path_file_names}-----*
#--------------------------------------------------------------------------
import argparse
import pandas as pd
import os


""" Handle arguments """
parser = argparse.ArgumentParser(
    description="TCGA sample sheet formatting"
)

parser.add_argument("-i", "--input_file",type=argparse.FileType('r'),
    help="input sample sheet", required=True
)

parser.add_argument("-o", "--output_file", type=argparse.FileType('w'), 
      help="Output file", required=True
      )

parser.add_argument("-d", "--input_dir_path", type=str, 
      help="Directory path to prepend to BAM file names",required=True)

args = parser.parse_args()
input_file = args.input_file
output_file = args.output_file


data = pd.read_csv(input_file, delimiter=',')

# Initialize a dictionary to store the matched BAM files
matched_samples = []

# Iterate through the rows and match based on sample_barcode
for patient_id in data['donor_barcode'].unique():
    # Filter rows for the current patient
    patient_data = data[data['donor_barcode'] == patient_id]
    
    # Find tumor and normal BAMs
    tumor_bam = patient_data[patient_data['specimen_type'].str.contains('Primary tumour', na=False)]['file_name']
    normal_bam = patient_data[patient_data['specimen_type'].str.contains('Normal', na=False)]['file_name']
    
    # If both tumor and normal BAMs exist, add them to the matched list
    if not tumor_bam.empty and not normal_bam.empty:
        matched_samples.append({
            'PATIENT_ID': patient_id,
            'NORMAL_BAM': os.path.join(args.input_dir_path, normal_bam.values[0]),
            'TUMOR_BAM': os.path.join(args.input_dir_path, tumor_bam.values[0])
        })

# Create a DataFrame from the matched samples
matched_df = pd.DataFrame(matched_samples)

# Save the new DataFrame to a CSV file

matched_df.to_csv(output_file, index=False)
#print(f"Matched BAM files saved to {output_file}")

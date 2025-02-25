#!/usr/bin/env python3
#---------------------------------------------------------------------------
#    To combine all the csv files 
#---- * Usage : python3 .py -i {input_files} -o {output_file} -d {directory_path_file_names}-----*
#--------------------------------------------------------------------------
import argparse
import pandas as pd
import os

""" Handle arguments """
parser = argparse.ArgumentParser(
    description="List of all the summary_tsv files"
)

parser.add_argument("-i", "--input_files", type=str,
    help="list of all the summary tsv files", required=True
)

parser.add_argument("-o", "--output_file",type=str, 
      help="Output file", required=True
      )


args = parser.parse_args()
input_list = args.input_files.split(',')
output_file = args.output_file

print(input_list)
combined_df = pd.DataFrame()


for idx, input_file in enumerate(input_list):
    if idx == 0:
        df = pd.read_csv(input_file, sep=',')
    else:
        df = pd.read_csv(input_file, sep=',', header=0)
    
    combined_df = pd.concat([combined_df, df], ignore_index=True)

combined_df.to_csv(output_file, sep=',', index=False)


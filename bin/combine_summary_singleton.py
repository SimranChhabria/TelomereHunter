#!/usr/bin/env python3
#---------------------------------------------------------------------------
#    To combine singleton and summary files
#---- * Usage : python3 .py -i {input_files} -o {output_file} -----*
#--------------------------------------------------------------------------
import argparse
import pandas as pd
import os

""" Handle arguments """
parser = argparse.ArgumentParser(
    description="List of all the summary_tsv files"
)

parser.add_argument("-i", "--summary_file", type=str,
    help="list of all the summary tsv files", required=True
)

parser.add_argument("-s", "--singleton_file", type=str,
    help="list of all the singleton tsv files", required=True
)

parser.add_argument("-o", "--output_file",type=str, 
      help="Output file", required=True
      )


args = parser.parse_args()
output_file = args.output_file


summary_df = pd.read_csv(args.summary_file, sep='\t')
singleton_df = pd.read_csv(args.singleton_file, sep='\t')


singleton_df = singleton_df.iloc[:, :4]
df_melted = singleton_df.melt(id_vars=['PID', 'pattern'], 
                    value_vars=['singleton_count_tumor', 'singleton_count_control'],
                    var_name='count_type',
                    value_name='count')


df_melted['new_col'] = df_melted['pattern'] + '_' + df_melted['count_type']
df_pivoted = df_melted.pivot(index='PID', 
                            columns='new_col', 
                            values='count').reset_index()

df_melted = df_pivoted.melt(id_vars=['PID'], 
                           var_name='column',
                           value_name='count')

# Extract type and pattern
df_melted['sample'] = df_melted['column'].apply(lambda x: 'tumor' if 'tumor' in x else 'control')
df_melted['pattern'] = df_melted['column'].apply(lambda x: x.split('_singleton_count_')[0])
df_melted['new_col'] = df_melted['pattern'] + '_singleton_count'

final_df = df_melted.pivot_table(index=['PID', 'sample'], 
                                columns='new_col', 
                                values='count').reset_index()

print(final_df)


combined_df = pd.merge(summary_df, final_df, on=['PID', 'sample'], how='left')
combined_df.to_csv(output_file, sep=',', index=False)
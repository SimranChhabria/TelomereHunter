process COMBINE_SS {
    tag "$meta.id"
    label 'process_single'

    publishDir "${params.out_dir}/", mode: 'copy'

    input:
    tuple val(meta), path(summary), path(singleton)

    output:
    path ("${meta.id}_summary_singletons.csv")   , emit : outputs

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    python $baseDir/bin/combine_summary_singleton.py -i ${summary} -s ${singleton} -o ${prefix}_summary_singletons.csv
    """
    
}

process COMBINE_SUMMARY {
    tag "combine"
    label 'process_single'

    publishDir "${params.out_dir}/", mode: 'copy'


    input:
    path input_files

    output:
    path ("*summary_combined.csv")   , emit : outputs

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def inputs = input_files.collect { it.toString() }.join(',')

    """
    python $baseDir/bin/combine_tsv.py -i $inputs -o summary_combined.csv
    """
}
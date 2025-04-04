process TELOMEREHUNTER {
    tag "$meta.id"
    label 'process_single'

    publishDir "${params.out_dir}/", mode: 'copy'

    conda "${moduleDir}/environment.yml"

    input:
    tuple val(meta), path(tumor_bam), path(normal_bam)

    output:
    tuple val(meta), path("*")                  , emit: outputs
    tuple val(meta), path ("results_${meta.id}/*/*_summary.tsv")      , emit : summary
    tuple val(meta), path ("results_${meta.id}/*/*_singletons.tsv")   , emit : singletons
    path "versions.yml"                         , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    if [ -f "${tumor_bam}" ] && [ -f "${normal_bam}" ]; then
    mkdir -p ./results_${prefix}

    telomerehunter \
        -ibt ${tumor_bam} \
        -ibc ${normal_bam} \
        -o ./results_${prefix} \
        -p ${prefix} \
        $args
    else
      echo "One or both BAM files do not exist: ${tumor_bam}, ${normal_bam}"
      exit 1
    fi

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        telomerehunter: \$(samtools --version |& sed '1!d ; s/samtools //')
    END_VERSIONS
    """
    
}
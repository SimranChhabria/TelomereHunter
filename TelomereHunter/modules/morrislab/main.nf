process TELOMEREHUNTER {
    tag "$meta.id"
    label 'process_single'

    publishDir "${params.out_dir}/", mode: 'copy'

    conda "${moduleDir}/environment.yml"

    input:
    tuple val(meta), path(tumor_bam), path(normal_bam)

    output:
    tuple val(meta), path("*"), emit: outputs
    path "versions.yml"               , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    telomerehunter \\
        -ibt ${tumor_bam} \\
        -ibc ${normal_bam} \\
        -o ${params.out_dir} \\
        -p ${prefix} \\
        $args

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        telomerehunter: \$(samtools --version |& sed '1!d ; s/samtools //')
    END_VERSIONS
    """
    
}
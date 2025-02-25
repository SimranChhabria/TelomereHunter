process TELOMEREHUNTER {
    tag "$meta.id"
    label 'process_high'

    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/pureclip:1.3.1--0':
        'asntech/telomerehunter:v1.1.0' }"

    
    input:
    tuple val(meta), path(tumor_bam), path(normal_bam)

    output:
    tuple val(meta), path("${meta.id}_prefix")              , emit : outputs
    path "versions.yml"                                     , emit : versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    if [ -f "${tumor_bam}" ] && [ -f "${normal_bam}" ]; then

    telomerehunter \
        -ibt ${tumor_bam} \
        -ibc ${normal_bam} \
        -o ${prefix}_results \
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

    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    

    """
    mkdir ${prefix}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        telomerehunter: \$(samtools --version |& sed '1!d ; s/samtools //')
    END_VERSIONS
    """

}
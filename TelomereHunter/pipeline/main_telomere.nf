#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { TELOMEREHUNTER } from '../modules/morrislab/main.nf'

workflow  {

    // input = [ [ id:'test', single_end:false ], // meta map
    //           file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true) ]
    bams_ch = Channel.fromFilePairs(params.input_bam,
          size: 2,
          flat: false)
          .map { sample, files ->
                def tumor_bam = files.find { it.name.contains('T') }
                def normal_bam = files.find { it.name.contains('N') }

                def meta = [
                    id       : sample]
                [meta, tumor_bam, normal_bam]
            }

    bams_ch.view { "bams_ch: ${it}"}
    
    TELOMEREHUNTER ( bams_ch )
}
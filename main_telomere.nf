#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { TELOMEREHUNTER } from './modules/morrislab/main.nf'

workflow  {
    
    // bams_ch = Channel.fromFilePairs(params.input_bam,
    //       size: 2,
    //       flat: false)
    //       .map { sample, files ->
    //             def tumor_bam = files.find { it.name.contains('T') }
    //             def normal_bam = files.find { it.name.contains('N') }

    //             def meta = [
    //                 id       : sample]
    //             [meta, tumor_bam, normal_bam]
    //         }
    
    // bams_ch.view { "bams_ch: ${it}"}

    samplesheet_ch = sample_names(file(params.sample_sheet, checkIfExists: true))
    samplesheet_ch.view()
    
    TELOMEREHUNTER ( samplesheet_ch )
}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    FUNCTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

def sample_names(csv_file) {

    // check that the sample sheet is not 1 line or less, because it'll skip all subsequent checks if so.
    file(csv_file).withReader('UTF-8') { reader ->
        def line, numberOfLinesInSampleSheet = 0;
        while ((line = reader.readLine()) != null) {numberOfLinesInSampleSheet++}
        if (numberOfLinesInSampleSheet < 2) {
            log.error "Samplesheet had less than two lines. The sample sheet must be a csv file with a header, so at least two lines."
            System.exit(1)
        }
    }

    Channel.of(csv_file).splitCsv(header: true)
        .map{ row ->
           def PATIENT_ID  = row['PATIENT_ID']
           def TUMOR_BAM = row['BAM_PATH']
           def NORMAL_BAM = row['BAM_PATH_TO_NORMALS'] 
           return [PATIENT_ID,TUMOR_BAM,NORMAL_BAM]
        }.map{PATIENT_ID,TUMOR_BAM,NORMAL_BAM ->
          def meta = [
                     id       : PATIENT_ID]
          return [meta, TUMOR_BAM, NORMAL_BAM]}

}
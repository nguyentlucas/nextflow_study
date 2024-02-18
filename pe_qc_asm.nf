params.read_1 = "$PWD/SRR26244988_1.fastq.gz"
params.read_2 = "$PWD/SRR26244988_2.fastq.gz"

log.info """\
         SIMPLE PAIRED_END QC ASSEMBLY PIPELINE    
         ===================================
         read_1              : ${params.read_1}
         read_2              : ${params.read_2}
         """
         .stripIndent()

process qual_control {
    publishDir "$PWD/trim", mode: 'copy'

    input:
    path read_1
    path read_2

    output:
    path "r1.paired.fq.gz"
    path "r2.paired.fq.gz"


    script:
    """
    mkdir -p "$PWD/trim"
    trimmomatic PE -phred33 $read_1 $read_2 "r1.paired.fq.gz" "r1_unpaired.fq.gz" "r2.paired.fq.gz" "r2_unpaired.fq.gz" SLIDINGWINDOW:5:30 AVGQUAL:30
    """
}

process assemble {

    input:
    path trimmed_read_1
    path trimmed_read_2
    
    script:
    """
    mkdir -p "$PWD/asm"
    spades.py -o "$PWD/asm" -1 $trimmed_read_1 -2 $trimmed_read_2
    """
}

workflow {
    read_1_ch = channel.fromPath(params.read_1)
    read_2_ch = channel.fromPath(params.read_2)
    qual_control(read_1_ch, read_2_ch) | assemble
}
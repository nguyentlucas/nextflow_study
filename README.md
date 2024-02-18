# nextflow_study

A beginner study of Nextflow.

Nextflow script that takes in a set of paired-end reads, quality control with trimmomatic, and assemble with spades.
---
# usage

nextflow run pe_qc_asm.nf --read_1 <read_1.fastq.gz> --read_2 <read_2.fastq.gz>

example:

nextflow run pe_qc_asm.nf --read_1 ./SRR26244988_1.fastq.gz --read_2 ./SRR26244988_2.fastq.gz

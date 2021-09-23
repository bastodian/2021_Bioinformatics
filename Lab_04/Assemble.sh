#!/bin/bash

# uncompress all read files
tar xvzf SequencingReads.tar.gz

# Combine all fastq files
cat *right.fq > Sp_COMBINED_right.fq
cat *left.fq > Sp_COMBINED_left.fq

# Assemble combined data using Trinity 
./trinityrnaseq-v2.13.2/Trinity --seqType fq --left Sp_COMBINED_left.fq --right Sp_COMBINED_right.fq --CPU 4 --max_memory 10G --output trinity_Assembly --trimmomatic --no_bowtie

# Build an index for the Reference assembly
bowtie2-build trinity_Assembly.Trinity.fasta Trinity

# Map reads against Trinity assembly
bowtie2 -x Trinity -1 ./Sp_ds.10k.left.fq -2 ./Sp_ds.10k.right.fq | samtools view -Sb - > Trinity.bam

# Process and view alugned reads
samtools sort Trinity.bam -o Trinity.sorted.bam
samtools index Trinity.sorted.bam
samtools faidx trinity_Assembly.Trinity.fasta
#samtools tview Trinity.sorted.bam trinity_Assembly.Trinity.fasta

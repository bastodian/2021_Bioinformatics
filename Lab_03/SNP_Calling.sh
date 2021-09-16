#!/bin/bash

# Map FastQ files to reference (human chromosome 12)
bowtie2 --threads 4 -x Reference/chr1 -1 FastQ/Child_Blood.Fwd.fastq -2 FastQ/Child_Blood.Rev.fastq | samtools view -bS - > Child_Blood.bam
bowtie2 --threads 4 -x Reference/chr1 -1 FastQ/Mother_Blood.Fwd.fastq -2 FastQ/Mother_Blood.Rev.fastq | samtools view -bS - > Mother_Blood.bam

# Sort and remove PCR duplicates from BAM mapping files using Samtools
samtools sort Child_Blood.bam Child_Blood.sorted
samtools rmdup -S Child_Blood.sorted.bam Child_Blood.NoDups.bam
samtools sort Mother_Blood.bam Mother_Blood.sorted
samtools rmdup -S Mother_Blood.sorted.bam Mother_Blood.NoDups.bam

# Call SNPs using FreeBayes
freebayes --bam Mother_Blood.NoDups.bam --bam Child_Blood.NoDups.bam --fasta-reference Reference/chr1.fa --theta 0.001 --ploidy 1 -K -j -m 30 -i -X -u > SNPs.vcf

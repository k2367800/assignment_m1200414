#!/bin/bash #

#Task 2.3 (cont) alignment using BWA

mkdir ~/m1200414/assignment/data/aligned_data

bwa mem -t 4 -v 1 -R '@RG\tID:11V6WR1.111.D1375ACXX.1.NGS01\tSM:NGS01\tPL:ILLUMINA\tLB:nextera-ngs01-blood\tDT:2025-03-29\tPU:D1375ACXX' ~/m1200414/assignment/data/reference/hg19.fa.gz ~/m1200414/assignment/data/trimmed_fastq/NGS0001_trimmed_R_1P.fastq ~/m1200414/assignment/data/trimmed_fastq/NGS0001_trimmed_R_2P.fastq | samtools view -bS - > ~/m1200414/assignment/data/aligned_data/NGS0001_aligned.bam

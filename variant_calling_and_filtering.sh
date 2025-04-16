#!/bin/bash # 

zcat ~/m1200414/assignment/data/reference/hg19.fa.gz > ~/m1200414/assignment/data/reference/hg19.fa
samtools faidx ~/m1200414/assignment/data/reference/hg19.fa

freebayes --bam ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam --fasta-reference ~/m1200414/assignment/data/reference/hg19.fa --vcf ~/m1200414/assignment/results/NGS0001.vcf
bgzip ~/m1200414/assignment/results/NGS0001.vcf
tabix -p vcf ~/m1200414/assignment/results/NGS0001.vcf.gz

vcffilter -f "QUAL > 1 & QUAL / AO > 10 & SAF > 0 & SAR > 0 & RPR > 1 & RPL > 1" ~/m1200414/assignment/results/NGS0001.vcf.gz > ~/m1200414/assignment/results/NGS0001_filtered.vcf

bedtools intersect -header -wa -a ~/m1200414/assignment/results/NGS0001_filtered.vcf -b ~/m1200414/assignment/data/annotation.bed > ~/m1200414/assignment/results/NGS0001_filtered_annotation.vcf

bgzip ~/m1200414/assignment/results/NGS0001_filtered_annotation.vcf

tabix -p vcf ~/m1200414/assignment/results/NGS0001_filtered_annotation.vcf.gz


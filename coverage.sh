#!/bin/bash #

##Task 2.3 - coverage data
# For chromosome 1
awk '$1 == "chr1"' ~/m1200414/assignment/data/annotation.bed > chr1_annotations.bed
bedtools coverage -a chr1_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr1_coverage.txt
rm chr1_annotations.bed

# For chromosome 2
awk '$1 == "chr2"' ~/m1200414/assignment/data/annotation.bed > chr2_annotations.bed
bedtools coverage -a chr2_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr2_coverage.txt
rm chr2_annotations.bed

# For chromosome 3
awk '$1 == "chr3"' ~/m1200414/assignment/data/annotation.bed > chr3_annotations.bed
bedtools coverage -a chr3_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr3_coverage.txt
rm chr3_annotations.bed

# For chromosome 4
awk '$1 == "chr4"' ~/m1200414/assignment/data/annotation.bed > chr4_annotations.bed
bedtools coverage -a chr4_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr4_coverage.txt
rm chr4_annotations.bed

# For chromosome 5
awk '$1 == "chr5"' ~/m1200414/assignment/data/annotation.bed > chr5_annotations.bed
bedtools coverage -a chr5_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr5_coverage.txt
rm chr5_annotations.bed

# For chromosome 6
awk '$1 == "chr6"' ~/m1200414/assignment/data/annotation.bed > chr6_annotations.bed
bedtools coverage -a chr6_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr6_coverage.txt
rm chr6_annotations.bed

# For chromosome 7
awk '$1 == "chr7"' ~/m1200414/assignment/data/annotation.bed > chr7_annotations.bed
bedtools coverage -a chr7_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr7_coverage.txt
rm chr7_annotations.bed

# For chromosome 8
awk '$1 == "chr8"' ~/m1200414/assignment/data/annotation.bed > chr8_annotations.bed
bedtools coverage -a chr8_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr8_coverage.txt
rm chr8_annotations.bed

# For chromosome 9
awk '$1 == "chr9"' ~/m1200414/assignment/data/annotation.bed > chr9_annotations.bed
bedtools coverage -a chr9_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr9_coverage.txt
rm chr9_annotations.bed

# For chromosome 10
awk '$1 == "chr10"' ~/m1200414/assignment/data/annotation.bed > chr10_annotations.bed
bedtools coverage -a chr10_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr10_coverage.txt
rm chr10_annotations.bed

# For chromosome 11
awk '$1 == "chr11"' ~/m1200414/assignment/data/annotation.bed > chr11_annotations.bed
bedtools coverage -a chr11_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr11_coverage.txt
rm chr11_annotations.bed

# For chromosome 12
awk '$1 == "chr12"' ~/m1200414/assignment/data/annotation.bed > chr12_annotations.bed
bedtools coverage -a chr12_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr12_coverage.txt
rm chr12_annotations.bed

# For chromosome 13
awk '$1 == "chr13"' ~/m1200414/assignment/data/annotation.bed > chr13_annotations.bed
bedtools coverage -a chr13_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr13_coverage.txt
rm chr13_annotations.bed

# For chromosome 14
awk '$1 == "chr14"' ~/m1200414/assignment/data/annotation.bed > chr14_annotations.bed
bedtools coverage -a chr14_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr14_coverage.txt
rm chr14_annotations.bed

# For chromosome 15
awk '$1 == "chr15"' ~/m1200414/assignment/data/annotation.bed > chr15_annotations.bed
bedtools coverage -a chr15_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr15_coverage.txt
rm chr15_annotations.bed

# For chromosome 16
awk '$1 == "chr16"' ~/m1200414/assignment/data/annotation.bed > chr16_annotations.bed
bedtools coverage -a chr16_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr16_coverage.txt
rm chr16_annotations.bed

# For chromosome 17
awk '$1 == "chr17"' ~/m1200414/assignment/data/annotation.bed > chr17_annotations.bed
bedtools coverage -a chr17_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr17_coverage.txt
rm chr17_annotations.bed

# For chromosome 18
awk '$1 == "chr18"' ~/m1200414/assignment/data/annotation.bed > chr18_annotations.bed
bedtools coverage -a chr18_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr18_coverage.txt
rm chr18_annotations.bed

# For chromosome 19
awk '$1 == "chr19"' ~/m1200414/assignment/data/annotation.bed > chr19_annotations.bed
bedtools coverage -a chr19_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr19_coverage.txt
rm chr19_annotations.bed

# For chromosome 20
awk '$1 == "chr20"' ~/m1200414/assignment/data/annotation.bed > chr20_annotations.bed
bedtools coverage -a chr20_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr20_coverage.txt
rm chr20_annotations.bed

# For chromosome 21
awk '$1 == "chr21"' ~/m1200414/assignment/data/annotation.bed > chr21_annotations.bed
bedtools coverage -a chr21_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr21_coverage.txt
rm chr21_annotations.bed

# For chromosome 22
awk '$1 == "chr22"' ~/m1200414/assignment/data/annotation.bed > chr22_annotations.bed
bedtools coverage -a chr22_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chr22_coverage.txt
rm chr22_annotations.bed

# For chromosome X
awk '$1 == "chrX"' ~/m1200414/assignment/data/annotation.bed > chrX_annotations.bed
bedtools coverage -a chrX_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chrX_coverage.txt
rm chrX_annotations.bed

# For chromosome Y
awk '$1 == "chrY"' ~/m1200414/assignment/data/annotation.bed > chrY_annotations.bed
bedtools coverage -a chrY_annotations.bed -b ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam -sorted > chrY_coverage.txt
rm chrY_annotations.bed


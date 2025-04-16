#!/bin/bash #

##Task 2.3 - part 3 - perform quality filter of the duplicate marked BAM file 

cd ~/m1200414/assignment/data/aligned_data
samtools view -F 1796 -q 20 -o NGS0001_sorted_filtered.bam NGS0001_sorted_marked.bam
samtools index NGS0001_sorted_filtered.bam 



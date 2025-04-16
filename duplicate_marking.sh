#!/bin/bash #

##Task 2.3 - part 2 - Perform duplicate marking
cd ~/m1200414/assignment/data/aligned_data
picard MarkDuplicates I=NGS0001_sorted.bam O=NGS0001_sorted_marked.bam M=marked_duplicates_metrics.txt
samtools index NGS0001_sorted_marked.bam



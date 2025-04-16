#!/bin/bash #

##Task 2.3 section 4 - generate standard alignment stats 
cd data/aligned_data/
samtools flagstat NGS0001_sorted_filtered.bam > NGS0001_sorted_filtered_flagstat.txt
samtools flagstat NGS0001_sorted_marked.bam > NGS0001_sorted_unfiltered_flagstat.txt
samtools idxstats NGS0001_sorted_filtered.bam > NGS0001_idxstats.txt
picard CollectInsertSizeMetrics I=NGS0001_sorted_filtered.bam O=NGS0001_insertsizemetrics.txt H=NGS0001_insertsizemetrics.pdf

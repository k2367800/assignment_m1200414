#!/bin/bash #

##Task 2.3 (cont.)
#After alignment, we use samtools for further work on the aligned data

cd ~/m1200414/assignment/data/aligned_data
samtools sort NGS0001_aligned.bam > NGS0001_sorted.bam
samtools index NGS0001_sorted.bam


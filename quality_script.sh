#!/bin/bash #

## TASK 2.2 Pre-Alignment QC
# Quality assessment of untrimmed files
echo Quality assessment of untrimmed files 
echo

cd ~/m1200414/assignment/data/untrimmed_fastq
fastqc -t 4 *.fastq.gz

mkdir ~/m1200414/assignment/results/fastqc_untrimmed_reads
mv *fastqc* ~/m1200414/assignment/results/fastqc_untrimmed_reads


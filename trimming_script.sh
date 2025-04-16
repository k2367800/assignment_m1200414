#!/bin/bash #

## TASK 2.2 (cont.) 
#Trimming using trimmomatic 

cd ~/m1200414/assignment/data/untrimmed_fastq

trimmomatic PE  \
  -threads 4 \
  -phred33 \
  /home/ubuntu/m1200414/assignment/data/untrimmed_fastq/NGS0001.R1.fastq.gz /home/ubuntu/m1200414/assignment/data/untrimmed_fastq/NGS0001.R2.fastq.gz \
  -baseout /home/ubuntu/m1200414/assignment/data/trimmed_fastq/NGS0001_trimmed_R \
  ILLUMINACLIP:/home/ubuntu/miniconda3/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/NexteraPE-PE.fa:2:30:10 \
  TRAILING:25 MINLEN:50



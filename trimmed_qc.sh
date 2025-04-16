#!/bin/bash/ #
## Task 2.2 (cont.)

#Now running QC on trimmed reads 

cd ~/m1200414/assignment/data/trimmed_fastq
mv NGS0001_trimmed_R_1P NGS0001_trimmed_R_1P.fastq
mv NGS0001_trimmed_R_2P NGS0001_trimmed_R_2P.fastq

fastqc -t 4 *trimmed*

mkdir ~/m1200414/assignment/results/fastqc_trimmed_reads
mv *fastqc* ~/m1200414/assignment/results/fastqc_trimmed_reads

#Now we will remove the files we no longer need 
#We have downloaded and reviewed the fastqc results for trimmed and untrimmed reads, so we can remove those directories

rm -r ~/m1200414/assignment/results/fastqc_trimmed_reads
rm -r ~/m1200414/assignment/results/fastqc_untrimmed_reads

#We no longer need the fastq untrimmed reads, so we can delete those too
rm -r ~/m1200414/assignment/data/untrimmed_fastq

## Task 2.3 
#Indexing the reference 

bwa index ~/m1200414/assignment/data/reference/hg19.fa.gz




#!/bin/bash #

## Task 2.1 
#It is assummed that all tools and dependencies have been downloaded as outlined in the assignment document. 
#The input files will be downloaded as part of the bash script 

echo ***PLEASE NOTE*** It is assumed that all tools and dependencies have been downloaded as outlined in the assignment document. The input files and relevant directories will be downloaded or created as part of this bash script. 
echo


# For clarity, we can make directories. 
cd 
mkdir ~/m1200414
mkdir ~/m1200414/assignment
mkdir ~/m1200414/assignment/data
mkdir ~/m1200414/assignment/results
cd ~/m1200414/assignment/data
mkdir untrimmed_fastq trimmed_fastq reference aligned_data

# We can download the input files into the correct directory. 
cd ~/m1200414/assignment/data/untrimmed_fastq
wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/NGS0001.R1.fastq.qz
wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/NGS0001.R2.fastq.qz

# We rename the fastq files so that they are the in .fastq.gz format
mv NGS0001.R1.fastq.qz NGS0001.R1.fastq.gz
mv NGS0001.R2.fastq.qz NGS0001.R2.fastq.gz

# We can download the bed file into the data directory.
cd ~/m1200414/assignment/data
wget https://s3-eu-west-1.amazonaws.com/workshopdata2017/annotation.bed

# We can download the reference genome hg19 into the reference directory
cd ~/m1200414/assignment/data/reference 
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.fa.gz

## TASK 2.2 Pre-Alignment QC
# Quality assessment of untrimmed files

cd ~/m1200414/assignment/data/untrimmed_fastq
fastqc -t 4 *.fastq.gz

mkdir ~/m1200414/assignment/results/fastqc_untrimmed_reads
mv *fastqc* ~/m1200414/assignment/results/fastqc_untrimmed_reads

echo We transferred the results into our local machine using Filezilla
echo

# Trimming 

cd ~/m1200414/assignment/data/untrimmed_fastq

trimmomatic PE  \
  -threads 4 \
  -phred33 \
  /home/ubuntu/m1200414/assignment/data/untrimmed_fastq/NGS0001.R1.fastq.gz /home/ubuntu/m1200414/assignment/data/untrimmed_fastq/NGS0001.R2.fastq.gz \
  -baseout /home/ubuntu/m1200414/assignment/data/trimmed_fastq/NGS0001_trimmed_R \
  ILLUMINACLIP:/home/ubuntu/miniconda3/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/NexteraPE-PE.fa:2:30:10 \
  TRAILING:25 MINLEN:50

#Quality assessment of trimmed files

cd ~/m1200414/assignment/data/trimmed_fastq
mv NGS0001_trimmed_R_1P NGS0001_trimmed_R_1P.fastq
mv NGS0001_trimmed_R_2P NGS0001_trimmed_R_2P.fastq

fastqc -t 4 *trimmed*

mkdir ~/m1200414/assignment/results/fastqc_trimmed_reads
mv *fastqc* ~/m1200414/assignment/results/fastqc_trimmed_reads

echo We can move the results to our local machine using Filezilla.
echo

#Now we will remove the files we no longer need
#We have downloaded and reviewed the fastqc results for trimmed and untrimmed reads, so we can remove those directories

rm -r ~/m1200414/assignment/results/fastqc_trimmed_reads
rm -r ~/m1200414/assignment/results/fastqc_untrimmed_reads

#We no longer need the fastq untrimmed reads, so we can delete those too
rm -r ~/m1200414/assignment/data/untrimmed_fastq

## Task 2.3: Alignment using Bowtie2

#Index the reference genome
bowtie2-build ~/m1200414/assignment/data/reference/hg19.fa.gz ~/m1200414/assignment/data/reference/hg19

#Aligning using Bowtie2
cd ~/m1200414/assignment/data/aligned_data

bowtie2 -p 4 \
  -1 ~/m1200414/assignment/data/trimmed_fastq/NGS0001_trimmed_R_1P.fastq \
  -2 ~/m1200414/assignment/data/trimmed_fastq/NGS0001_trimmed_R_2P.fastq \
  -S NGS0001_aligned.sam \
  ~/m1200414/assignment/data/reference/hg19

samtools view -bS NGS0001_aligned.sam > NGS0001_aligned.bam
samtools sort NGS0001_aligned.bam -o NGS0001_sorted.bam
samtools index NGS0001_sorted.bam

#Duplicate marking

picard MarkDuplicates I=NGS0001_sorted.bam O=NGS0001_sorted_marked.bam M=marked_duplicates_metrics.txt
samtools index NGS0001_sorted_marked.bam

#Quality filter

samtools view -F 1796 -q 20 -o NGS0001_sorted_filtered.bam NGS0001_sorted_marked.bam
samtools index NGS0001_sorted_filtered.bam

#Post-Alignment Statistics 

samtools flagstat NGS0001_sorted_filtered.bam > NGS0001_sorted_filtered_flagstat.txt
samtools flagstat NGS0001_sorted_marked.bam > NGS0001_sorted_unfiltered_flagstat.txt
samtools idxstats NGS0001_sorted_filtered.bam > NGS0001_idxstats.txt
picard CollectInsertSizeMetrics I=NGS0001_sorted_filtered.bam O=NGS0001_insertsizemetrics.txt H=NGS0001_insertsizemetrics.pdf

#Depth of coverage
echo Depth of coverage was broken down by chromosomes as working memory did not allow for overall file
echo
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

#Move stats files to new directory
mkdir ~/m1200414/assignment/results/alignment_stats
mv *.txt ~/m1200414/assignment/results/alignment_stats/
mv *.pdf ~/m1200414/assignment/results/alignment_stats/

#Remove files no longer needed
cd ~/m1200414/assignment
rm -r ~/m1200414/assignment/data/trimmed_fastq/
cd data/aligned_data/
rm NGS0001_aligned.bam NGS0001_sorted.bam NGS0001_sorted.bam.bai

## Task 2.4 Variant Calling 
#Variant calling with Freebayes

zcat ~/m1200414/assignment/data/reference/hg19.fa.gz > ~/m1200414/assignment/data/reference/hg19.fa
samtools faidx ~/m1200414/assignment/data/reference/hg19.fa

freebayes --bam ~/m1200414/assignment/data/aligned_data/NGS0001_sorted_filtered.bam --fasta-reference ~/m1200414/assignment/data/reference/hg19.fa --vcf ~/m1200414/assignment/results/NGS0001.vcf
bgzip ~/m1200414/assignment/results/NGS0001.vcf
tabix -p vcf ~/m1200414/assignment/results/NGS0001.vcf.gz

#Quality filter 

vcffilter -f "QUAL > 1 & QUAL / AO > 10 & SAF > 0 & SAR > 0 & RPR > 1 & RPL > 1" ~/m1200414/assignment/results/NGS0001.vcf.gz > ~/m1200414/assignment/results/NGS0001_filtered.vcf

bedtools intersect -header -wa -a ~/m1200414/assignment/results/NGS0001_filtered.vcf -b ~/m1200414/assignment/data/annotation.bed > ~/m1200414/assignment/results/NGS0001_filtered_annotation.vcf

bgzip ~/m1200414/assignment/results/NGS0001_filtered_annotation.vcf

tabix -p vcf ~/m1200414/assignment/results/NGS0001_filtered_annotation.vcf.gz

## Task 2.5 Variant annotation and prioritisation 
#Annonate variants using ANNOVAR

echo We assume that ANNOVAR and relevant reference databases have been downloaded as outlined in the assignment document 
echo 

cd ~/annovar 
./convert2annovar.pl -format vcf4 ~/m1200414/assignment/results/NGS0001_filtered_annotation.vcf.gz > ~/m1200414/assignment/results/NGS0001_filtered_annotation.avinput

./table_annovar.pl ~/m1200414/assignment/results/NGS0001_filtered_annotation.avinput humandb/ -buildver hg19 -out ~/m1200414/assignment/results/NGS0001_filtered_annotation -remove -protocol refGene,ensGene,clinvar_20180603,exac03,avsnp150 -operation g,g,f,f,f -otherinfo -nastring . -csvout

echo We can transfer the output file to our local machine using Filezilla 
echo 

#Annotate variants using snpEFF

echo We will download snpEFF, the relevant reference and run the annotation
echo

wget https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip
unzip snpEff_latest_core.zip
cd snpEff
java -jar snpEff.jar download hg19
java -jar snpEff.jar hg19 ~/m1200414/assignment/results/NGS0001_filtered_annotation.vcf.gz > ~/m1200414/assignment/results/NGS0001_filtered_annotation.snpeff.vcf

#Remove snpEFF
cd
rm -rf snpEff

#Perform basic variant prioritisation 
#This was done using excel as outlined in the assignment document.

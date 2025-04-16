#!/bin/bash #

##Steps at the end of QC/stats after alignment

#Move stats files to new directory
mkdir ~/m1200414/assignment/results/annotation_qc
mv *.txt ~/m1200414/assignment/results/annotation_qc/
mv *.pdf ~/m1200414/assignment/results/annotation_qc/

#Remove files no longer needed
cd ~/m1200414/assignment
rm -r ~/m1200414/assignment/data/trimmed_fastq/
cd data/aligned_data/
rm NGS0001_aligned.bam NGS0001_sorted.bam NGS0001_sorted.bam.bai

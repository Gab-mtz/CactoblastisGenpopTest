#!/bin/bash
# This script can be using to clean genomic paired end data. All the files needed must to be in the same working directoy. You can change the parameters as you want.
echo "Start at:"
date

trimmomatic PE -threads 24 Cactoblastis_S111_L001_R1_001.fastq.gz Cactoblastis_S111_L001_R2_001.fastq.gz \
Plate_R1_PAIRED.fastq.gz Plate_R1_Unpaired.fastq.gz \
Plate_R2_PAIRED.fastq.gz Plate_R2_Unpaired.fastq.gz \
ILLUMINACLIP:Sequencing_adaptors.fasta:2:30:10 \
LEADING:25 TRAILING:25 SLIDINGWINDOW:4:20 MINLEN:110
echo "Ends at:"
date



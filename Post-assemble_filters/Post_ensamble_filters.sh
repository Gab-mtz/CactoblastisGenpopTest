#!/bin/bash

# This script contains the comand line to run vcftools in order to filter your snps.
# We recommend execute the sequence in the order of this script
# Note that the output file of each step is the input file of the next
# Read the vcf file
vcftools --vcf Yourfile.vcf
# Filter of two alleles
vcftools --vcf Yourfile.vcf --min-alleles 2 --max-alleles 2 --recode --out Yourfile_2alleles
# Filter of missing data which allows 20% of missing data
vcftools --vcf Yourfile_2alleles.recode.vcf --max-missing 0.8 --recode --out Yourfile_2allel_20miss
# Filter of minor allele frequency (MAF) 
vcftools --vcf Yourfile_2allel_20miss.recode.vcf --maf 0.01 --recode --out Yourfile_2allel_20miss_01MAF 
# Filter of Hardy-Weinberg
vcftools --vcf Yourfile_2allel_20miss_01MAF.recode.vcf --hwe 0.001 --recode --out Yourfile_2allel_20miss_01MAF_HW001
# Filter of linkage disequilibrium
vcftools --vcf Yourfile_2allel_20miss_01MAF_HW001.recode.vcf --thin 250 --recode --out Yourfile_2allel_20miss_01MAF_HW001_thin250
# The file "Yourfile_2allel_20miss_01MAF_HW001_thin250" is the final file which you can use for future analysis

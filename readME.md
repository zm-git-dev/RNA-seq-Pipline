# Generalized RNA-seq pipeline for Gene Differential Expression Analysis and Gene-set Enrichment Analysis

This simple RNA-seq pipeline was written by me for self-study and exposure to NGS-data analysis.

## Tool requirements for this pipeline
1. Linux command line that uses some sort of shell (I used basic BASH).
2. hisat2 was used as the aligner of choice.
3. featureCounts software was used to determine coverage/abundances in all samples
4. R statistical programming, along with the bioconductor package.
5. samtools for manipulating BAM files.
6. ermineJ software for gene-set enrichment analysis (optional).

## Data used to test this software
I used RNA-seq/reference data from this tutorial online. The link outlines the type of data and how the samples were
designed for their particular experiment. I made sure the dataset wasn't too large, in order to run and test
the pipeline as quickly and efficiently as possible.

## Instructions for running this pipeline
1. Clone this directory into where you want it to be on your desktop/laptop.

2. Move into this directory and place your data into the reads folder. Your refs directory should contain the reference
   genome you want to align your RNA-seq data to, along with the GTF file for estimating gene feature abundance/counts.

3. Your read data files should follow this naming format, in order for this pipeline to correctly work:
   SAMPLENAME_REPLICATE_PAIREDENDNUMBER.fq

   SAMPLENAME = The name you want to give for the particular sample condition in your experiment.

   REPLICATE = Which particular replicate is it in your sample condition (2 vs. 3 vs 4, etc). 

   PAIREDENDNUMBER = If the study used paired end replication, then you should have a read data file for each end, otherwise
   there will be only one.

   The example data (paired end data) in this repository uses a naming convention like so:
   UHR_1_R1.fq
   UHR_1_R2.fq
   HBR_1_R1.fq
   HBR_1_R2.fq
   UHR_2_R1.fq
   UHR_2_R2.fq 
   ...........
   ...........

   Once you have all the data in the correct naming convention and in their proper folder locations, run this command on the 
   command line:

   ```bash

   bash rnaSeqPipline.sh

   ```
   The program should prompt you with questions about your data/experiment, in which you should answer on the
   command line. This should provide you with your results in several text files that you can use in further analysis



## Contact Information
Email - wongak626@gmail.com
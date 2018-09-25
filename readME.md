# Generalized RNA-seq pipeline for Gene Differential Expression Analysis and Gene-set Enrichment Analysis

This simple RNA-seq pipeline was written by me for self-study and exposure to NGS-data analysis. This piepleine will
perform RNA-seq alignment for user specified read data, conduct coverage/abundance counts against a user specified
gene feature structure, and format results for gene-set enrichment analysis. Most NGS pipelines are created for the
sole purpose of a particular experiment within the lab. Many efforts within the bioinformatics community have been
trying to generalize NGS pipelines for general use, but still requires fruitful dedication. For this pipeline, I will try 
to generalize the analysis for RNA-seq experiments as much as possible.

## Tool/software requirements for this pipeline
1. Linux command line that uses some sort of shell (I used basic BASH).
2. hisat2 was used as the aligner of choice.
3. featureCounts software was used to determine coverage/abundances in all samples
4. R statistical programming, along with the bioconductor package.
5. samtools for manipulating BAM files.
6. ermineJ software for gene-set enrichment analysis (optional).

## Data used to test this pipeline
I used RNA-seq/reference data from this [tutorial](https://github.com/griffithlab/rnaseq_tutorial/wiki/RNAseq-Data) online. 
The link outlines the type of data, and how the samples were designed for this particular experiment. Reference genome 
data was indexed using hisat2 using this command: 

```bash
hisat2-build *filepath of reference genome* *filepath of intended prefix index files*
```

Note that **this pipeline is for paired-end reads**. I will add code for aligning single end reads in the future.

## Instructions for running this pipeline
1. Clone this repo into where you want it to be on your desktop/laptop.

2. Move into this directory and create to new folders called "reads" and "refs". You will place your read data into the 
   reads folder, while your refs directory should contain the reference genome you want to align your RNA-seq data to, 
   along with the GTF file for estimating gene feature abundance/counts. Like so:

   Main Folder/<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reads/<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;refs/<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rnaSeqPipeline.sh<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;script1.r<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;script2.r<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;readME.md<br/>


3. Your read data files should follow this naming format, in order for this pipeline to correctly work:

   SAMPLENAME_REPLICATE_PAIREDENDNUMBER.fq

   SAMPLENAME = The name you want to give for the particular sample condition in your experiment.

   REPLICATE = Which particular replicate is it in your sample condition (2 vs. 3 vs 4, etc). 

   PAIREDENDNUMBER = If the study used paired end replication, then you should have a read data file for each paired end, otherwise there will be only one. Please name them as "R1" vs "R2".

   The example data (paired end data) in this repository uses a naming convention like so:
   
   > UHR_1_R1.fq<br/>
   > UHR_1_R2.fq<br/>
   > HBR_1_R1.fq<br/>
   > HBR_1_R2.fq<br/>
   > UHR_2_R1.fq<br/>
   > UHR_2_R2.fq<br/>
   > ...........<br/>

   Once you have all the data in the correct naming convention and in their proper folder locations, run this command on the 
   command line:

   ```bash

   bash rnaSeqPipline.sh

   ```
   The program should prompt you with questions about your data/experiment, in which you should answer on the
   command line. This should provide you with your results in several text files that you can use for gene-set 
   feature analysis.



## Contact Information
Email - wongak626@gmail.com
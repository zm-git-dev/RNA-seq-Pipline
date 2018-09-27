# Generalized RNA-seq pipeline for Gene Differential Expression Analysis and Gene-set Enrichment Analysis

This simple RNA-seq pipeline was written by me, for self-study and exposure to NGS-data analysis. This pipeline will
perform RNA-seq alignment for user specified read data, conduct coverage/abundance counts against a user specified
gene feature structure, and format results for gene-set enrichment analysis. For this pipeline, I will try 
to generalize the analysis for RNA-seq experiments as much as possible for the purpose of learning the complexities
within RNA-seq data analysis.

## Tool/software requirements for this pipeline
1. Linux based command line that uses some sort of shell (I used basic BASH).
2. Hisat2 was used as the aligner of choice.
3. FeatureCounts software was used to determine coverage/abundances in all samples.
4. R statistical programming, along with the bioconductor package.
5. Samtools for manipulating BAM files.
6. ErmineJ software for gene-set enrichment analysis (optional).

## Data used to test this pipeline
I used RNA-seq/reference data from this [tutorial](https://github.com/griffithlab/rnaseq_tutorial/wiki/RNAseq-Data) online. 
The link outlines the type of data, and how the samples were designed for this particular experiment. Reference genome 
data was indexed using hisat2 with this command: 

```bash
hisat2-build *filepath of reference genome* *filepath of intended prefix index files*
```

Note that **this pipeline is for paired-end reads**. I will add code for aligning single end reads in the future.

## Instructions for running this pipeline
1. Clone this repo into where you want it to be on your desktop/laptop.

2. Move into this directory. You will place your read data into the reads folder, while your refs directory should 
   contain the reference genome you want to align your RNA-seq data to, along with the GTF file for estimating gene 
   feature abundance/counts. Like so:

   Main Folder/<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reads/<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;refs/<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rnaSeqPipeline.sh<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;deseq.r<br/>
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
   command line. This should provide you with your results in several text files that you can use for gene-set feature analysis:

   - counts.txt
   - simple_counts.txt
   - norm-matrix-deseq.txt
   - results.txt
   - geneScore.txt
   - heatmap.pdf

## Gene-set enrichment analysis/functional analysis
   
   Using the results generated from the shell script, we can now use ErmineJ to conduct Over-representation analysis and on our list of differentially expressed genes. ErmineJ software requires these main input files for Over-representation analysis and Gene Score Resampling:

   Annotation file: For my tests, I used the [generic human](https://gemma.msl.ubc.ca/annots/Generic_human_noParents.an.txt.gz) GO XML file from their website. ErmineJ provides users with the option to download annotation files for many organisms from their own [website](https://gemma.msl.ubc.ca/annots/). 

   Gene score file: geneScore.txt

   Expression data: norm-matrix-deseq.txt

   In the ORA representation analysis, default parameters should be selected, with a gene score threshold of 0.05 and max/min gen set size set to 500 and 5 respectively. The best gene scoring option was also selected as default. The negative log of gene scores option was selected for this analysis, since we used p-values in our gene score file. For the gene score resampling analysis, the same default parameters were chosen as well, with the best scoring replicate selection, and 100000 replicates chosen.

## Results
   
   Table diagram of associated cell pathways/functions that had the most enriched genes based on ORA/GSR analysis from ErmineJ software.
   ![alt text]()

   Tree diagram of associated cell pathways/functions that had the most enriched genes based on ORA/GSR analysis from ErmineJ software. Proccesses in green are considered to be statistically relevant and enriched in this particular experiment.

## Pipeline Diagram

   ![alt text](https://github.com/wongak626/RNA-seq-Pipline/blob/master/readMEimages/Slide1.jpg?raw=true "Pipeline Diagram")

## Future Directions
   - Add QC measures
   - Add single-end read functionality
   - Improve heatmap.R script
   - Add command line functionality of ErmineJ to shell script


## Contact Information
Email - wongak626@gmail.com
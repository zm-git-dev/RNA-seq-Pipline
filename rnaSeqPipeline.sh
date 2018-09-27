#!/usr/bin/env bash

# This pipeline was designed to conduct the following on RNA-seq data:
# 1) Align user specified RNA-seq data against user designated genome
# 2) Generate abundances/counts for all samples 
# 3) Generate a list of differentially expressed genes for
#    gene enrichment studies
# 4) Generate a cluster heatmap for visualizing differentially 
#    expressed genes from sample RNA-seq data
# 
#   


# Exit this script on any error.
set -euo pipefail

# This keeps track of the messages printed during execution.
RUNLOG=runlog.txt

echo "Run by `whoami` on `date`" > $RUNLOG

# Create output folder
mkdir -p bam

# This part of the script performs alignments of the user read data against 
# a specified genomic index in: $IDX

# Ask user what the read data will be aligned against
echo -n "Please provide the filename of the reference genome fasta file in your refs folder -> "

read ref1

# The index determines what the data is aligned against.

IDX=refs/$ref1

# Ask user the name of the gene feature file that will be used to conduct counts against.
echo -n "Please provide the filename of the associated gene feature file (gtf) in your refs folder -> "
read gtf

GTF=refs/$gtf

# Ask user to provide sample naming format and number of replicates
echo -n "Please provide the names used for each sample/condition separated by a space -> "
read 

#echo "REPLY = '$REPLY'"

# Ask the user to provide the number of replicates used for each sample/condition
echo -n "Please provide the number of replicates used for each sample/condition -> "
read int


# Iterate over each sample and conduct alignment to reference genome/sequence, create index 
# for BAM file results

for SAMPLE in $REPLY;
do
    # Iterate over each of the replicates.
    for ((i=1;i<=$int;i++));
    do
        # Build the name of the files.
        R1=reads/${SAMPLE}_${i}_R1.fq
        R2=reads/${SAMPLE}_${i}_R2.fq
        BAM=bam/${SAMPLE}_${i}.bam

        # Run the aligner.
        echo "*** Aligning: $BAM"
        hisat2 $IDX -1 $R1 -2 $R2 2>> $RUNLOG | samtools sort > $BAM 2>> $RUNLOG
        samtools index $BAM
    done
done

# This part of the script makes use of the BAM files to compute coverage counts

# Generate the counts with featureCounts software.
echo "*** Counting features with: $GTF"
featureCounts -a $GTF -g gene_name -o counts.txt  bam/H*.bam  bam/U*.bam 2>> $RUNLOG

# Simplify the file to keep only the count columns.
echo "*** Generating table that only includes counts."
cat counts.txt | cut -f 1,7-12 > simple_counts.txt

# Run DESeq method on the simple count file to generate results, creates heatmap.
echo "*** Running DESeq."
#cat simple_counts.txt | Rscript deseq1.r 3x3 > results.txt  2>> $RUNLOG
cat simple_counts.txt | Rscript deseq.r $intx$int > results.txt  2>> $RUNLOG

# Create geneScore file
cat results.txt | cut -f 1,8 > geneScore.txt


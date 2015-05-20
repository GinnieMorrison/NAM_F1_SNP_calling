#!/bin/bash -l
#SBATCH -D /home/ginnie/data
#SBATCH -o /home/ginnie/data/logs/bamdex_stdout-%j.txt
#SBATCH -e /home/ginnie/data/logs/bamdex_stderr-%j.txt
#SBATCH -J bamdex
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=10000 #watch out for this one. Too much and have to run on bigmem
#SBATCH --cpus-per-task=1

set -e
set -u
#/share/apps/samtools-1.2/samtools sort -o JRIVB15B_srt.bam  -T srt.bam -O 'bam' JRIVB15B.bam
/share/apps/samtools-1.2/samtools index JRIVB15B_srt.bam 

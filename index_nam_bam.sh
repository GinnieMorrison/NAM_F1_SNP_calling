#!/bin/bash -l
#SBATCH -D /home/ginnie/data/Call_SNPs_All
#SBATCH -o /home/ginnie/data/Call_SNPs_All/logs/bamdex_stdout-%j.txt
#SBATCH -e /home/ginnie/data/Call_SNPs_All/logs/bamdex_stderr-%j.txt
#SBATCH -J bamdex
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=8000 #watch out for this one. Too much and have to run on bigmem
#SBATCH --cpus-per-task=2

set -e
set -u

merges=$(ls JRI*rh.bam|xargs echo)
for merge in ${merges}
 do
  echo "$merge"
  /share/apps/samtools-1.2/samtools index "$merge"
 done
echo "Job Done: "
date

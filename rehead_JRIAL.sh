#!/bin/bash -l
#SBATCH -D /home/ginnie/data/Call_SNPs_All
#SBATCH -o /home/ginnie/data/Call_SNPs_All/logs/angsdpval_out-%j.txt
#SBATCH -e /home/ginnie/data/Call_SNPs_All/logs/angsdpval_err-%j.txt
#SBATCH -J angsdpval
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=8000
#SBATCH --cpus-per-task=1

set -e
set -u

JRIbam=$(ls JRI*bam | xargs echo)

for f in ${JRIbam}
 do

  filename=${f%%.*}

  cp rehead.sam "$filename".sam 

#  echo -e "@RG\tID:"$filename"\tSM:"$filename".bam\tLB:"$filename".bam\tPL:ILLUMINA" >> "$filename".sam
  
  cmd="/share/apps/samtools-1.2/samtools reheader "$filename".sam "$f" > "$filename"_rh.bam"
  echo $cmd
  eval $cmd
 done
echo "Job Done: "
date

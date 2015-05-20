#!/bin/bash -l
#SBATCH -D /home/ginnie/data/NAM_BAM
#SBATCH -o /home/ginnie/data/NAM_BAM/slurm-log/merge_out-%j.txt
#SBATCH -e /home/ginnie/data/NAM_BAM/slurm-log/merge_err-%j.txt
#SBATCH -J merge
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
set -e
set -u


 srtd=$(ls *srt.bam | xargs echo)
 echo "$srtd"
 for bam in srtd
  do
   prefix="${bam%%.*}"
   /share/apps/samtools-1.2/samtools merge -c "$prefix"_merge.bam $bam
  done


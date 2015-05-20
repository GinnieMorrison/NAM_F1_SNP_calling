#!/bin/bash -l
#SBATCH -D /home/ginnie/data
#SBATCH -o /home/ginnie/data/NAM_BAM/slurm-log/irsync_bams_out-%j.txt
#SBATCH -e /home/ginnie/data/NAM_BAM/slurm-log/irsync_bams_err-%j.txt
#SBATCH -J irsync_bams
set -e
set -u

/home/ginnie/data/iplant_retrieve.sh nam_bam_bwa_iplant.txt

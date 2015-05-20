#!/bin/bash -l
#SBATCH -D /home/ginnie/data/NAM_BAM
#SBATCH -o /home/ginnie/data/NAM_BAM/slurm-log/sort_out-%j.txt
#SBATCH -e /home/ginnie/data/NAM_BAM/slurm-log/sort_err-%j.txt
#SBATCH -J sort
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
set -e
set -u

./sort.sh bamlist.txt

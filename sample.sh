#!/bin/bash -l
#SBATCH -D /home/ginnie/y/x/
#SBATCH -o /home/ginnie/y/x/slurm-log/steve-stdout-%j.txt
#SBATCH -e /home/ginnie/y/x/slurm-log/steve-stderr-%j.txt
#SBATCH -J jobname
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=10000 #watch out for this one. Too much and have to run on bigmem
#SBATCH --cpus-per-task=1

set -e
set -u

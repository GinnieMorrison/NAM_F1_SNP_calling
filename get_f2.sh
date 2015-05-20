#!/bin/bash -l
#SBATCH -D /home/ginnie/data
#SBATCH -o /home/ginnie/data/logs/get_f2_out-%j.txt
#SBATCH -e /home/ginnie/data/logs/get_f2_err-%j.txt
#SBATCH -J get_f2
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
set -e
set -u

iget /iplant/home/rossibarra/teo_f2/JRIVB20C.sorted.bam

echo "Job Done: "
date

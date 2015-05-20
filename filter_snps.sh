#!/bin/bash -l
#SBATCH -D /home/ginnie/data/Call_SNPs_All
#SBATCH -o /home/ginnie/data/Call_SNPs_All/logs/filtersnps_out-%j.txt
#SBATCH -e /home/ginnie/data/Call_SNPs_All/logs/filtersnps_err-%j.txt
#SBATCH -J filtersnps
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=4000
#SBATCH --cpus-per-task=1

set -e
set -u

echo "Start Job: "
date

gunzip All_Founders_q40_7_1e6_F.geno.gz
 
python ~/scripts/filter_snps_hard.py All_Founders_q40_7_1e6_F.geno All_Founders_q40_Filtered.txt

gzip All_Founders_q40_7_1e6_F.geno

echo "Job Done: "
date

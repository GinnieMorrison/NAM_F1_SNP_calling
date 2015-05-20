#!/bin/bash -l
#SBATCH -D /home/ginnie/data/Call_SNPs_All
#SBATCH -o /home/ginnie/data/Call_SNPs_All/logs/cutB73_out-%j.txt
#SBATCH -e /home/ginnie/data/Call_SNPs_All/logs/cutB73_err-%j.txt
#SBATCH -J cutB73
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=4000
#SBATCH --cpus-per-task=1

set -e
set -u

echo "Start Job: "
date

zcat All_Founders_q60_7_1e6_F.geno.gz |cut -f 5 |uniq -c > B73_call_summary_q60_7_1e6_F.txt

echo "Job Done: "
date

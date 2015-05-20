#!/bin/bash -l
#SBATCH -D /home/ginnie/data
#SBATCH -o /home/ginnie/data/logs/get_gt_out-%j.txt
#SBATCH -e /home/ginnie/data/logs/get_gt_err-%j.txt
#SBATCH -J F2_chr1_get_gt
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=6000
#SBATCH --cpus-per-task=1

set -e
set -u

echo "Job Started: "
date
vcfs=$(ls F2_chr1*call.bcf|xargs echo)
for vcf in ${vcfs}
 do
  prefix=${vcf%%.*}
  /share/apps/bcftools-1.2/bin/bcftools query -f '%CHROM\t%POS\t%QUAL[\t%GT]\n' $vcf > GT_$prefix.txt
 
 done
echo "Job Done: "
date

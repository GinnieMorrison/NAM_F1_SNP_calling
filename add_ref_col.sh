#!/bin/bash -l
#SBATCH -D /home/ginnie/data/angst_test_folder
#SBATCH -o /home/ginnie/data/logs/fixref_out-%j.txt
#SBATCH -e /home/ginnie/data/logs/fixref_err-%j.txt
#SBATCH -J fixref
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=8000
#SBATCH --cpus-per-task=1

set -e
set -u
##made with python 2.7.x
echo "Start Job: "
date

file_in=$(ls TIL*chr4*q40*geno | xargs echo)

for i in ${file_in}
 do
  prefix=${i%%.*}
  #echo "$prefix"
  echo "zcat "$prefix".mafs.gz | cut -f 5 |grep -v ref|paste - "$prefix".geno >  Ref_"$prefix".geno "
  echo
  zcat "$prefix".mafs.gz | cut -f 5 |grep -v ref|paste - "$prefix".geno >  Ref_"$prefix".geno 
done

echo "Job Done: "
date

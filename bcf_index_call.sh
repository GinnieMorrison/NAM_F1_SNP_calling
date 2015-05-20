#!/bin/bash -l
#SBATCH -D /home/ginnie/data
#SBATCH -o /home/ginnie/data/logs/calltest_out-%j.txt
#SBATCH -e /home/ginnie/data/logs/calltest_err-%j.txt
#SBATCH -J calltest
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=8000
#SBATCH --cpus-per-task=1

set -e
set -u

bcfs=$(ls F2_TIL_chr[0-9].bcf |xargs echo)
echo $bcfs

for file in ${bcfs}
 do
  echo "$file"
  prefix="${file%%.*}"
  echo "$prefix"
  chrm="${prefix: -1}"
  echo "$chrm"

  if [ ! -f "$file".csi ]; then
   /share/apps/bcftools-1.2/bin/bcftools index "$file"
  fi
  cmd="/share/apps/bcftools-1.2/bin/bcftools call -O b -f GP,GQ -r "$chrm" -Mm -o "$prefix"_call.bcf "$file""
  echo $cmd
  eval $cmd
 done
echo "Job Done: "
date

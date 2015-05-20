#!/bin/bash -l
#SBATCH -D /home/ginnie/data
#SBATCH -o /home/ginnie/data/logs/angsdpval_out-%j.txt
#SBATCH -e /home/ginnie/data/logs/angsdpval_err-%j.txt
#SBATCH -J angsdpval
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=8000
#SBATCH --cpus-per-task=1

set -e
set -u

adir=/home/ginnie/bin/angsd
bamList=angsd_bam.txt
regionfile=3:
inbreed=inF.txt
outputdir=angst_test_folder
minMapQ=60
ref=Zea_mays.AGPv3.22.dna.chromosome.3.fa
uniqO=0
baq=1
outname=TIL_F2_chr3_GT_angst_q60_7_1e6_uniform
calltype=7
post=2
cutoff=0.95
pval=1e-6
command1="-bam "$bamList" -out "$outputdir"/"$outname"_F -indF "$inbreed" -doMajorMinor 4 -uniqueOnly "$uniqO" -minMapQ "$minMapQ" -minQ 20 -ref "$ref" -GL 2 -r "$regionfile" -doGeno "$calltype" -doPost "$post" -postCutoff "$cutoff" -doMaf 1 -SNP_pval "$pval" " 
echo $command1
echo
$adir/angsd $command1

echo "Job Done: "
date

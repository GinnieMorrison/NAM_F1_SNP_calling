#!/bin/bash -l
#SBATCH -D /home/ginnie/data/Call_SNPs_All
#SBATCH -o /home/ginnie/data/Call_SNPs_All/logs/angsdpval_out-%j.txt
#SBATCH -e /home/ginnie/data/Call_SNPs_All/logs/angsdpval_err-%j.txt
#SBATCH -J angsdpval
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=8000
#SBATCH --cpus-per-task=16

set -e
set -u

adir=/home/ginnie/bin/angsd
bamList=Founder_bams.txt
regionfile=Chr_List.txt
inbreed=Founder_F.txt
#outputdir= .
minMapQ=40
ref=v2_numeric_chr.fasta
uniqO=0
baq=1
outname=All_Founders_q40_7_1e6
calltype=7
post=1
cutoff=0.95
pval=1e-6

command1="-bam "$bamList" -out "$outname"_F -indF "$inbreed" -doMajorMinor 4 -uniqueOnly "$uniqO" -minMapQ "$minMapQ" -minQ 20 -ref "$ref" -GL 2 -rf "$regionfile" -doGeno "$calltype" -doPost "$post" -postCutoff "$cutoff" -doMaf 1 -SNP_pval "$pval" " 
echo $command1
echo
$adir/angsd $command1

echo "Job Done: "
date

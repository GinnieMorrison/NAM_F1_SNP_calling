#!/bin/bash -l
#SBATCH -D /home/ginnie/data
#SBATCH -o /home/ginnie/data/logs/til05_1_o-%j.txt
#SBATCH -e /home/ginnie/data/logs/til05_1_e-%j.txt
#SBATCH -J F2_chr1_mpile
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=6000
#SBATCH --cpus-per-task=1

set -e
set -u

/share/apps/samtools-1.2/samtools mpileup -C50 -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP,DV,DPR,SP -r '1' -q30 -Q20 TIL05.sorted.bam JRIVB15B_srt.bam > F2_TIL_chr1.bcf

/share/apps/samtools-1.2/samtools mpileup -C50 -gf Zea_mays.AGPv3.22.dna.chromosome.3.fa -t DP,DV,DPR,SP -r '3' -q30 -Q20 TIL05.sorted.bam JRIVB15B_srt.bam > F2_TIL_chr3.bcf

/share/apps/samtools-1.2/samtools mpileup -C50 -gf Zea_mays.AGPv3.22.dna.chromosome.4.fa -t DP,DV,DPR,SP -r '4' -q30 -Q20 TIL05.sorted.bam JRIVB15B_srt.bam > F2_TIL_chr4.bcf
echo "Job Done: "
date

#!/bin/bash -l
#SBATCH -D /home/ginnie/data
#SBATCH -o /home/ginnie/data/logs/F2_chr1_mpileup-%j.txt
#SBATCH -e /home/ginnie/data/logs/F2_chr1_mpile-%j.txt
#SBATCH -J F2_chr1_mpile
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=6000
#SBATCH --cpus-per-task=1

set -e
set -u

 
#/share/apps/samtools-1.2/samtools mpileup -C50 -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -r '1' JRIVB15B_srt.bam > F2_chr1_M0_B13_C50.bcf

#/share/apps/samtools-1.2/samtools mpileup -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -r '1' JRIVB15B_srt.bam > F2_chr1_M0_B13.bcf

#/share/apps/samtools-1.2/samtools mpileup -C50 -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP,DV,DPR,SP -r '1' -q20  JRIVB15B_srt.bam > F2_chr1_M20_B13.bcf

#/share/apps/samtools-1.2/samtools mpileup -C50 -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP,DV,DPR,SP -r '1' -q30 JRIVB15B_srt.bam > F2_chr1_M30_B13.bcf

#/share/apps/samtools-1.2/samtools mpileup -C50 -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP,DV,DPR,SP -r '1' -Q20 JRIVB15B_srt.bam > F2_chr1_M0_B20.bcf

/share/apps/samtools-1.2/samtools mpileup -C50 -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP,DV,DPR,SP -r '1' -q20 -Q20 JRIVB15B_srt.bam > F2_chr1_M20_B20.bcf

#/share/apps/samtools-1.2/samtools mpileup -C50 -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP,DV,DPR,SP -r '1' -q30 -Q20 JRIVB15B_srt.bam > F2_chr1_M30_B20.bcf

#/share/apps/samtools-1.2/samtools mpileup -Egf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP,DV,DPR,SP -r '1' JRIVB15B_srt.bam > F2_chr1_E.bcf

#/share/apps/samtools-1.2/samtools mpileup -Bgf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP,DV,DPR,SP -r '1' JRIVB15B_srt.bam > F2_chr1_B.bcf
echo "Job Done: "
date

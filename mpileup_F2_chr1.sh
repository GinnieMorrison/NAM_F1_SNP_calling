#!/bin/bash -l
#SBATCH -D /home/ginnie/data
#SBATCH -o /home/ginnie/data/logs/mpileup_chr1_s-%j.txt
#SBATCH -e /home/ginnie/data/logs/mpileup_chr1_s-%j.txt
#SBATCH -J mpileup_chr1_s
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
#SBATCH --mem-per-cpu=4000
#SBATCH --cpus-per-task=1

set -e
set -u

 
#/share/apps/samtools-1.2/samtools mpileup -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP -r '1' JRIVB15B.sorted.bam > chr1_default.bcf

#/share/apps/samtools-1.2/samtools mpileup -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP -B -r '1' JRIVB15B.sorted.bam > chr1_noBAQ.bcf

#/share/apps/samtools-1.2/samtools mpileup -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP -r '1' -q30 JRIVB15B.sorted.bam > chr1_q30.bcf

#/share/apps/samtools-1.2/samtools mpileup -gf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP -r '1' -q20 JRIVB15B.sorted.bam > chr1_q20.bcf

/share/apps/samtools-1.2/samtools mpileup -sf Zea_mays.AGPv3.22.dna.chromosome.1.fa -t DP -r '1' -q20 JRIVB15B.sorted.bam > chr1_s.bcf

echo "Job Done: "
date

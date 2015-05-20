#!/bin/bash -l
#SBATCH -D /home/ginnie/data
#SBATCH -o /home/ginnie/data/logs/faix_out-%j.txt
#SBATCH -e /home/ginnie/data/logs/faix_err-%j.txt
#SBATCH -J faix_fa
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu
set -e
set -u
gunzip Zea_mays.AGPv3.22.dna.chromosome.3.fa.gz

gunzip Zea_mays.AGPv3.22.dna.chromosome.4.fa.gz

/share/apps/samtools-1.2/samtools faidx Zea_mays.AGPv3.22.dna.chromosome.3.fa

/share/apps/samtools-1.2/samtools faidx Zea_mays.AGPv3.22.dna.chromosome.4.fa

gzip Zea_mays.AGPv3.22.dna.chromosome.4.fa

gzip Zea_mays.AGPv3.22.dna.chromosome.3.fa

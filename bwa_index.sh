#!/bin/bash -l
#SBATCH -D /group/jrigrp4/ginnie/ref_v2
#SBATCH -o /group/jrigrp4/ginnie/ref_v2/logs/bwaidx_out-%j.txt
#SBATCH -e /group/jrigrp4/ginnie/ref_v2/logs/bwaidx_err-%j.txt
#SBATCH -J bwa_index
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=morrisong@missouri.edu

set -e
set -u

/share/apps/bwa-0.7.9a/bwa index AGP_v2.fasta

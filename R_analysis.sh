#!/bin/bash
#SBATCH -p general
#SBATCH -J LOW_E1_miRNA

#SBATCH --mail-type=ALL
#SBATCH --mail-user=albertomaria.moro@yale.edu

module use /ysm-gpfs/apps/modules/all

module load R-bundle-Bioconductor/3.4-foss-2016a-R-3.3.2

Rscript Script/featureCounts.R

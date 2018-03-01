#!/bin/bash
#SBATCH -p general
#SBATCH -J Bowtie_Cufflink
#SBATCH -N 4 -c 15
#SBATCH --mem-per-cpu=8000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=albertomaria.moro@yale.edu

module use /ysm-gpfs/apps/modules/all
module load R-bundle-Bioconductor/3.4-foss-2016a-R-3.3.2
module load FASTX-Toolkit/0.0.14-foss-2016a
module load Cufflinks
module load Bowtie2

#bash /ysm-gpfs/home/am2485/project/from_louise/Genome/Mouse/mm10/make_mm10.sh

#for file in ~/BY_fastq/alignment_RNA_seq/*.fastq
#do
#bowtie2 -k 7 --local --mm -q --phred33 -D 20 -R 3 -N 0 -L 8 -i S,1,0.50 -x ~/project/from_louise/Genome/Mouse/mm10/mm10 -q $file -S ${file/.fastq/.sam}
#done

cufflinks -p 8 -g ~/BY_fastq/alignment_RNA_seq/gencode.vM13.chr_patch_hapl_scaff.annotation.gtf -o ~/BY_fastq/alignment_RNA_seq/KO_cuff ~/BY_fastq/alignment_RNA_seq/CLIPlibrary_KO_R1_all.sort.bam
cufflinks -p 8 -g ~/BY_fastq/alignment_RNA_seq/gencode.vM13.chr_patch_hapl_scaff.annotation.gtf -o ~/BY_fastq/alignment_RNA_seq/WT_cuff ~/BY_fastq/alignment_RNA_seq/CLIPlibrary_WT_R1_all.sort.bam


#!/bin/bash
#SBATCH -p general
#SBATCH -J fastQC
#SBATCH -N 4 -c 15
#SBATCH --mem-per-cpu=8000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=albertomaria.moro@yale.edu

module use /ysm-gpfs/apps/modules/all
module load R-bundle-Bioconductor/3.4-foss-2016a-R-3.3.2
module load FastQC

#cd ~/project/Stiffness_mRNA_lexo_Dionna/mRNA
#for file in *.fastq
#do
#mkdir ${file/.fastq/_QC}
#fastqc $file -o ${file/.fastq/_QC}
#done
#tar -czf QC_results.tar.gz *_QC
#rm -r *_QC

cd ~/project/Stiffness_mRNA_lexo_Dionna/miRNA
for file in *.fastq
do
mkdir ${file/.fastq/_QC}
fastqc $file -o ${file/.fastq/_QC}
done
tar -czf QC_results.tar.gz *_QC
rm -r *_QC

#cd ~/project/223_mutant/Mouse
#for file in *.fastq
#do
#mkdir ${file/.fastq/_QC}
#fastqc $file -o ${file/.fastq/_QC}
#done
#tar -czf QC_results.tar.gz *_QC
#rm -r *_QC

#cd ~/project/223_mutant/Zebrafish
#for file in *.fastq
#do
#mkdir ${file/.fastq/_QC}
#fastqc $file -o ${file/.fastq/_QC}
#done
#tar -czf QC_results.tar.gz *_QC
#rm -r *_QC

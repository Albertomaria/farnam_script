#!/bin/bash
#SBATCH -p general
#SBATCH -J Salmon
#SBATCH -N 4 -c 15
#SBATCH --mem-per-cpu=8000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=albertomaria.moro@yale.edu

module use /ysm-gpfs/apps/modules/all
module load R-bundle-Bioconductor/3.4-foss-2016a-R-3.3.2
module load FASTX-Toolkit/0.0.14-foss-2016a
module load cutadapt
module load Salmon

#salmon index -t ~/project/Genome/Homo_sapiens.GRCh38.transcript.chr.fa -i ~/Hsa_index
#salmon index -t ~/project/Genome/Mus_musculus.GRCm38.transcript.chr.fa -i ~/Mmu_index
#salmon index -t ~/project/Genome/Danio_rerio.GRCz10.transcript.chr.fa -i ~/Dre_index
#salmon index -k 11 -t ~/project/Genome/Human/Homo_sapiens.GRCh38.Mat_miRNA.fa -i ~/project/Genome/Human/Hsa_miRNA_index


#cd ~/project/Stiffness_mRNA_lexo_Dionna/mRNA/
#for file in *.fastq
#do
#cutadapt -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -o ${file/.fastq/_temp.fastq} $file
#cutadapt -a "A{18}" -m 10 -o ${file/.fastq/_trim.fastq} ${file/.fastq/_temp.fastq}
#salmon quant -i ~/Hsa_index/ -l A -r ${file/.fastq/_trim.fastq} -o ~/project/Stiffness_mRNA_lexo_Dionna/Salmon/${file/.fastq/.salmon}
#rm ${file/.fastq/_temp.fastq}
#rm ${file/.fastq/_trim.fastq}
#done

cd ~/project/Stiffness_mRNA_lexo_Dionna/miRNA/
for file in *.fastq
do
cutadapt -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -o ${file/.fastq/_temp.fastq} $file
cutadapt -a "A{18}" -m 10 -o ${file/.fastq/_trim.fastq} ${file/.fastq/_temp.fastq}
salmon quant -i ~/project/Genome/Human//Hsa_miRNA_index/ -l A -r ${file/.fastq/_trim.fastq} -o ~/project/Stiffness_mRNA_lexo_Dionna/miRNA/Salmon_miR_only/${file/.fastq/.salmon}
rm ${file/.fastq/_temp.fastq}
rm ${file/.fastq/_trim.fastq}
done

#cd ~/project/223_mutant/Mouse
#for file in *.fastq
#do
#cutadapt -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -o ${file/.fastq/_temp.fastq} $file
#cutadapt -a "A{18}" -m 10 -o ${file/.fastq/_trim.fastq} ${file/.fastq/_temp.fastq}
#salmon quant -i ~/Mmu_index/ -l A -r ${file/.fastq/_trim.fastq} -o ~/project/223_mutant/Salmon_mouse/${file/.fastq/.salmon}
#rm ${file/.fastq/_temp.fastq}
#rm ${file/.fastq/_trim.fastq}
#done

#cd ~/project/223_mutant/Zebrafish
#for file in *.fastq
#do
#cutadapt -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -o ${file/.fastq/_temp.fastq} $file
#cutadapt -a "A{18}" -m 10 -o ${file/.fastq/_trim.fastq} ${file/.fastq/_temp.fastq}
#salmon quant -i ~/Dre_index/ -l A -r ${file/.fastq/_trim.fastq} -o ~/project/223_mutant/Salmon_zebrafish/${file/.fastq/.salmon}
#rm ${file/.fastq/_temp.fastq}
#rm ${file/.fastq/_trim.fastq}
#done


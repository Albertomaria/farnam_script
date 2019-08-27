#!/bin/bash
#SBATCH -p general
#SBATCH -J STAR
#SBATCH -N 4 -c 15
#SBATCH --mem-per-cpu=8000
#SBATCH --mail-type=ALL

module use /ysm-gpfs/apps/modules/all
module load R-bundle-Bioconductor/3.4-foss-2016a-R-3.3.2
module load FASTX-Toolkit/0.0.14-foss-2016a
module load cutadapt
module load STAR

#STAR --runMode genomeGenerate --genomeDir ~/project/Genome/Human/STARIndex --genomeFastaFiles ~/project/Genome/Human/GRCh38.primary_assembly.genome.fa --sjdbGTFfile ~/project/Genome/Human/gencode.v27.primary_assembly.annotation.gtf --runThreadN 12
#STAR --runMode genomeGenerate --genomeDir ~/project/Genome/Mouse/STARIndex --genomeFastaFiles ~/project/Genome/Mouse/GRCm38.primary_assembly.genome.fa --sjdbGTFfile ~/project/Genome/Mouse/gencode.vM15.primary_assembly.annotation.gtf --runThreadN 12
#STAR --runMode genomeGenerate --genomeDir ~/project/Genome/Zebrafish/STARIndex --genomeFastaFiles ~/project/Genome/Zebrafish/Danio_rerio.GRCz10.dna_sm.toplevel.fa --sjdbGTFfile ~/project/Genome/Zebrafish/Danio_rerio.GRCz10.90.chr.gtf --runThreadN 12
#STAR --runMode genomeGenerate --genomeDir ~/project/Genome/Human/ncRNA_STARIndex --genomeFastaFiles ~/project/Genome/Human/Homo_sapiens.GRCh38.ncrna.fa --sjdbGTFfile ~/project/Genome/Human/gencode.v27.primary_assembly.annotation.gtf --runThreadN 12
#STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ~/project/Genome/Human/miRNA_STARIndex --genomeFastaFiles ~/project/Genome/Human/GRCh38.primary_assembly.genome.fa --sjdbGTFfile ~/project/Genome/Human/gencode.v27.primary_assembly.annotation.gtf --sjdbOverhang 1

#cd ~/project/Stiffness_mRNA_lexo_Dionna/
#for file in *.fastq
#do
#cutadapt -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -o ${file/.fastq/_temp.fastq} $file
#cutadapt -a "A{18}" -m 10 -o ${file/.fastq/_trim.fastq} ${file/.fastq/_temp.fastq}
#STAR --runMode alignReads --genomeDir ~/project/Genome/Human/STARIndex --readFilesIn ${file/.fastq/_trim.fastq} --outFilterMismatchNmax 4 --runThreadN 12 --outFileNamePrefix ~/project/Stiffness_mRNA_lexo_Dionna/STAR/${file/.fastq/.STAR.} --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts
#rm ${file/.fastq/_temp.fastq}
#rm ${file/.fastq/_trim.fastq}
#done

params=' --runThreadN 16
--outFilterMismatchNmax 1
--outFilterMultimapScoreRange 0
--quantMode TranscriptomeSAM GeneCounts
--outReadsUnmapped Fastx
--outSAMtype BAM SortedByCoordinate
--outFilterMultimapNmax 10
--outSAMunmapped Within
--outFilterScoreMinOverLread 0
--outFilterMatchNminOverLread 0
--outFilterMatchNmin 16
--alignSJDBoverhangMin 1000
--alignIntronMax 1
--outWigType wiggle
--outWigStrand Stranded
--outWigNorm RPM
'

cd ~/project/Stiffness_mRNA_lexo_Dionna/miRNA
for file in *.fastq
do
cutadapt -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -o ${file/.fastq/_temp.fastq} $file
cutadapt -a "A{18}" -m 10 -o ${file/.fastq/_trim.fastq} ${file/.fastq/_temp.fastq}
STAR --genomeDir ~/project/Genome/Human/miRNA_STARIndex --readFilesIn ${file/.fastq/_trim.fastq} $params --outFileNamePrefix ~/project/Stiffness_mRNA_lexo_Dionna/miRNA/STAR/${file/.fastq/.STAR.} --sjdbGTFfile ~/project/Genome/Human/microRNA.subset.of.GENCODE.V27.gtf
rm ${file/.fastq/_temp.fastq}
rm ${file/.fastq/_trim.fastq}
done

#cd ~/project/223_mutant/Mouse
#for file in *.fastq
#do
#cutadapt -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -o ${file/.fastq/_temp.fastq} $file
#cutadapt -a "A{18}" -m 10 -o ${file/.fastq/_trim.fastq} ${file/.fastq/_temp.fastq}
#STAR --runMode alignReads --genomeDir ~/project/Genome/Mouse/STARIndex --readFilesIn ${file/.fastq/_trim.fastq} --outFilterMismatchNmax 4 --runThreadN 12 --outFileNamePrefix ~/project/223_mutant/STAR_mouse/${file/.fastq/.STAR.} --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts
#rm ${file/.fastq/_temp.fastq}
#rm ${file/.fastq/_trim.fastq}
#done

#cd ~/project/223_mutant/Zebrafish
#for file in *.fastq
#do
#cutadapt -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -o ${file/.fastq/_temp.fastq} $file
#cutadapt -a "A{18}" -m 10 -o ${file/.fastq/_trim.fastq} ${file/.fastq/_temp.fastq}
#STAR --runMode alignReads --genomeDir ~/project/Genome/Zebrafish/STARIndex --readFilesIn ${file/.fastq/_trim.fastq} --outFilterMismatchNmax 4 --runThreadN 12 --outFileNamePrefix ~/project/223_mutant/STAR_zebrafish/${file/.fastq/.STAR.} --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts
#rm ${file/.fastq/_temp.fastq}
#rm ${file/.fastq/_trim.fastq}
#done


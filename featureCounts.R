library(Rsubread)
ann <- "/ysm-gpfs/project/am2485/Genome/Human/microRNA.subset.of.GENCODE.V27.gtf"

setwd("/ysm-gpfs/project/am2485/Stiffness_mRNA_lexo_Dionna/miRNA/STAR")
files <- list.files(path = ".",pattern = "sortedByCoord")

for (f in files){
	f_name <- strsplit(f,".",fixed = T)[[1]][1]
	seq_data <- featureCounts(f,annot.ext=ann,isGTFAnnotationFile = TRUE, countMultiMappingReads=TRUE,allowMultiOverlap=TRUE)
	assign(f_name,seq_data$count)
	write.table(get(f_name),paste(f_name,".txt",sep=""),sep="\t",quote=F,col.names="ID\tNUMBER")
}



library("ChIPseqSpikeInFree")
metaFile <- "sample_meta_M10_R4.txt"
bams <- c("M10-R_corin_H3K27ac_R4.mappedq1.sort.rmdup.bam","M10-R_corin_H3K4me2_R4.mappedq1.sort.rmdup.bam","M10-R_corin_H3K9ac_R4.mappedq1.sort.rmdup.bam","M10-R_corin_Input_R4.mappedq1.sort.rmdup.bam","M10-R_DMSO_H3K27ac_R4.mappedq1.sort.rmdup.bam","M10-R_DMSO_H3K4me2_R4.mappedq1.sort.rmdup.bam","M10-R_DMSO_H3K9ac_R4.mappedq1.sort.rmdup.bam","M10-R_DMSO_Input_R4.mappedq1.sort.rmdup.bam")
ChIPseqSpikeInFree(bamFiles = bams, chromFile = "hg38", metaFile = metaFile, prefix = "M10_R4_rmdup")



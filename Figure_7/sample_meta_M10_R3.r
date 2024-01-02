library("ChIPseqSpikeInFree")
metaFile <- "sample_meta_M10_R3.txt"
bams <- c("M10-R_corin_H3K27ac_R3.mappedq1.sort.rmdup.bam","M10-R_corin_H3K4me2_R3.mappedq1.sort.rmdup.bam","M10-R_corin_H3K9ac_R3.mappedq1.sort.rmdup.bam","M10-R_corin_Input_R3.mappedq1.sort.rmdup.bam","M10-R_DMSO_H3K27ac_R3.mappedq1.sort.rmdup.bam","M10-R_DMSO_H3K4me2_R3.mappedq1.sort.rmdup.bam","M10-R_DMSO_H3K9ac_R3.mappedq1.sort.rmdup.bam","M10-R_DMSO_Input_R3.mappedq1.sort.rmdup.bam")
ChIPseqSpikeInFree(bamFiles = bams, chromFile = "hg38", metaFile = metaFile, prefix = "M10_R3_rmdup")



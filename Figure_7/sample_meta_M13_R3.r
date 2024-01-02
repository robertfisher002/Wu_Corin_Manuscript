library("ChIPseqSpikeInFree")
metaFile <- "sample_meta_M13_R3.txt"
bams <- c("M13-R_corin_H3K27ac_R3.mappedq1.sort.rmdup.bam","M13-R_corin_H3K4me2_R3.mappedq1.sort.rmdup.bam","M13-R_corin_H3K9ac_R3.mappedq1.sort.rmdup.bam","M13-R_corin_Input_R3.mappedq1.sort.rmdup.bam","M13-R_DMSO_H3K27ac_R3.mappedq1.sort.rmdup.bam","M13-R_DMSO_H3K4me2_R3.mappedq1.sort.rmdup.bam","M13-R_DMSO_H3K9ac_R3.mappedq1.sort.rmdup.bam","M13-R_DMSO_Input_R3.mappedq1.sort.rmdup.bam")
ChIPseqSpikeInFree(bamFiles = bams, chromFile = "hg38", metaFile = metaFile, prefix = "M13_R3_rmdup")



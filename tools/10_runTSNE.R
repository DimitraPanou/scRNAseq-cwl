library(dplyr)
library(Seurat)
library(patchwork)

#file
rds_file <- commandArgs(trailingOnly=TRUE)[1];

RA_pooled = readRDS(rds_file, refhook = NULL)
print("Started RunTSNE")
RA_pooled.subset <- RunTSNE(RA_pooled, dims = 1:32)#, umap.method = "umap-learn", metric = "correlation")
print("Finished RunTSNE")
saveRDS(RA_pooled.subset, file = "RunTSNE.rds")
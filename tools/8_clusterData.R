library(dplyr)
library(Seurat)
library(patchwork)

#file
rds_file <- commandArgs(trailingOnly=TRUE)[1];

RA_pooled = readRDS(rds_file, refhook = NULL)
print("Started Clustering")
RA_pooled.subset <- FindClusters(RA_pooled, resolution = c(0.6))
print("Finished Clustering")
saveRDS(RA_pooled.subset, file = "Clustering.rds")
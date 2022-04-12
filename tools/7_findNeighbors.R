library(dplyr)
library(Seurat)
library(patchwork)

#file
rds_file <- commandArgs(trailingOnly=TRUE)[1];
neighbors_method <- commandArgs(trailingOnly=TRUE)[2];

RA_pooled = readRDS(rds_file, refhook = NULL)
print("Started Find Neighbors")
RA_pooled.subset <- FindNeighbors(RA_pooled, dims = 1:32, nn.method = neighbors_method)
print("Finished Find Neighbors")
saveRDS(RA_pooled.subset, file = "FindNeighbors.rds")
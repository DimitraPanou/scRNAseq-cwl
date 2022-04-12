library(dplyr)
library(Seurat)
library(patchwork)

#file
rds_file <- commandArgs(trailingOnly=TRUE)[1];

RA_pooled = readRDS(rds_file, refhook = NULL)
print("Started Find Markers")
RA_pooled.subset@misc$markers <- FindAllMarkers(RA_pooled, logfc.threshold = 0.25, min.pct = 0.25, return.thresh = 0.01)

print("Finished Find Markers")
saveRDS(RA_pooled.subset, file = "FindAllMarkers.rds")
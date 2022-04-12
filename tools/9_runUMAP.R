library(dplyr)
library(Seurat)
library(patchwork)

#file
rds_file <- commandArgs(trailingOnly=TRUE)[1];

RA_pooled = readRDS(rds_file, refhook = NULL)
print("Started RunUMAP")
RA_pooled.subset <- RunUMAP(RA_pooled, dims = 1:32)#, umap.method = "umap-learn", metric = "correlation")
jpeg(file="umap_plot.jpeg")
DimPlot(RA_pooled.subset, reduction = "umap")
dev.off()
print("Finished RunUMAP")
saveRDS(RA_pooled.subset, file = "RunUMAP.rds")
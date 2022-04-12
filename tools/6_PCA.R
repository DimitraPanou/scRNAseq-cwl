library(dplyr)
library(Seurat)
library(patchwork)

#file
rds_file <- commandArgs(trailingOnly=TRUE)[1];

RA_pooled = readRDS(rds_file, refhook = NULL)
print("Started PCA")
RA_pooled.subset <- RunPCA(RA_pooled, features = VariableFeatures(object = RA_pooled))
print(RA_pooled.subset[["pca"]],dims = 1:5, nfeatures = 5)

jpeg(file="pca_1.jpeg")
VizDimLoadings(RA_pooled.subset, dims = 1:2, reduction = "pca")
dev.off()
jpeg(file="pca_2.jpeg")
DimPlot(RA_pooled.subset, reduction = "pca")
dev.off()
jpeg(file="pca_3.jpeg")
DimHeatmap(RA_pooled.subset, dims = 1:15, cells = 500, balanced = TRUE)
dev.off()
print("Finished PCA")
saveRDS(RA_pooled.subset, file = "PCA.rds")
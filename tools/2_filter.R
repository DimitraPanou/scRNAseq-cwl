library(dplyr)
library(Seurat)
library(patchwork)

#file
rds_file <- commandArgs(trailingOnly=TRUE)[1];
 
#Filtering parameters
#nFeature_RNA_min <- 300
#nFeature_RNA_max <- 3000
#nCount_RNA_min <- -Inf
#nCount_RNA_max <- Inf
#percentmt_min <- 0
#percentmt_max <- 5

nFeature_RNA_min <- commandArgs(trailingOnly=TRUE)[2]
nFeature_RNA_max <- commandArgs(trailingOnly=TRUE)[3]
nCount_RNA_min <- commandArgs(trailingOnly=TRUE)[4]
nCount_RNA_max <- commandArgs(trailingOnly=TRUE)[5]
percentmt_min <- commandArgs(trailingOnly=TRUE)[6]
percentmt_max <- commandArgs(trailingOnly=TRUE)[7]

RA_pooled = readRDS(rds_file, refhook = NULL)
RA_pooled.subset <- subset(RA_pooled, subset = nFeature_RNA > nFeature_RNA_min & nFeature_RNA < nFeature_RNA_max & nCount_RNA > nCount_RNA_min & nCount_RNA < nCount_RNA_max & percent.mt > percentmt_min & percent.mt < percentmt_max)

plot1 <- FeatureScatter(RA_pooled, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(RA_pooled, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
RA_pooled.plot_filtering <- VlnPlot(RA_pooled.subset, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
jpeg(file="plot1.jpeg")
RA_pooled.plot_filtering
dev.off()
saveRDS(RA_pooled.subset, file = "Filter.rds")
#saveRDS(RA_pooled.subset, file = "Filter.rds")

library(dplyr)
library(Seurat)
library(patchwork)

#file
rds_file <- commandArgs(trailingOnly=TRUE)[1];

RA_pooled = readRDS(rds_file, refhook = NULL)
print("Started Scaling")
RA_pooled.subset <- ScaleData(RA_pooled, vars.to.regress = c("percent.mt","nCount_RNA"))
print("Finished Scaling")
saveRDS(RA_pooled.subset, file = "Scaling.rds")
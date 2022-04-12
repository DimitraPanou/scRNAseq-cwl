library(dplyr)
library(Seurat)
library(patchwork)

#file
rds_file <- commandArgs(trailingOnly=TRUE)[1];


normalization_method <- commandArgs(trailingOnly=TRUE)[2]
scale_factor <- strtoi(commandArgs(trailingOnly=TRUE)[3])
margin <- strtoi(commandArgs(trailingOnly=TRUE)[4])
block_size <- commandArgs(trailingOnly=TRUE)[5]
verbose <- commandArgs(trailingOnly=TRUE)[6]
verbose <- TRUE
if(block_size == "NULL"){
	block_size <- NULL
}else{
	block_size <- strtoi(block_size)
}

RA_pooled = readRDS(rds_file, refhook = NULL)
print("Started Normalization")
RA_pooled.subset <- NormalizeData(RA_pooled, normalization.method = normalization_method, scale.factor = scale_factor, margin = margin, block.size = block_size,verbose = verbose) 
print("Finished Normalization")
saveRDS(RA_pooled.subset, file = "Normalization.rds")

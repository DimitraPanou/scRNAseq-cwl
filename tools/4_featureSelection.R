library(dplyr)
library(Seurat)
library(patchwork)

#file
rds_file <- commandArgs(trailingOnly=TRUE)[1];


selection_method <- commandArgs(trailingOnly=TRUE)[2]
loess_span <- strtoi(commandArgs(trailingOnly=TRUE)[3])
clip_max <- commandArgs(trailingOnly=TRUE)[4]
num_bin <- strtoi(commandArgs(trailingOnly=TRUE)[5])
binning_method <- commandArgs(trailingOnly=TRUE)[6]
nfeatures <- strtoi(commandArgs(trailingOnly=TRUE)[7])
verbose <- TRUE
RA_pooled = readRDS(rds_file, refhook = NULL)
print("Started Find Features")
RA_pooled.subset <- FindVariableFeatures(RA_pooled, selection.method = selection_method,loess.span = loess_span, clip.max = clip_max, num.bin = num_bin, binning.method = binning_method, verbose = verbose) 
top10 <- head(VariableFeatures(RA_pooled.subset),10)
print(top10)
plot1 <- VariableFeaturePlot(RA_pooled.subset)
plot2 <- LabelPoints(plot = plot1, points = top10, repel = TRUE)
RA_pooled.plot_variable_features <- plot1 + plot2
jpeg(file="find_features_data_plot.jpeg")
plot2
dev.off()
print("Finished Find Features")
saveRDS(RA_pooled.subset, file = "FeatureSelection.rds")

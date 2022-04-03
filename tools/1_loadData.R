library(dplyr)
library(Seurat)
library(patchwork)

print(commandArgs(trailingOnly=TRUE))

path = "./"

setwd(path)

#copy files for Seurat
barcodesPath <- commandArgs(trailingOnly=TRUE)[1];
featuresPath <- commandArgs(trailingOnly=TRUE)[2];
matrixPath <- commandArgs(trailingOnly=TRUE)[3];

file.copy(barcodesPath, paste("./", basename(barcodesPath), sep=""))
file.copy(featuresPath, paste("./", basename(featuresPath), sep=""))
file.copy(matrixPath, paste("./", basename(matrixPath), sep=""))

list.files(path="./")

mincells <- strtoi(commandArgs(trailingOnly=TRUE)[4], base = 0L)
minfeatures <- strtoi(commandArgs(trailingOnly=TRUE)[5], base = 0L)
projectname <- commandArgs(trailingOnly=TRUE)[6]
pattern <- commandArgs(trailingOnly=TRUE)[7]

print("reading start ...")
#Read Data
RA.datapooled <- Read10X(data.dir = getwd())
#Create Seaurat Object
print("Creating Seurat object")
RA.pooled  <- CreateSeuratObject(counts = RA.datapooled, project = projectname, min.cells = mincells)
RA.pooled[["percent.mt"]] <- PercentageFeatureSet(RA.pooled, pattern = pattern)
plot3 <- VlnPlot(RA.pooled, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
plot1 <- FeatureScatter(RA.pooled, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(RA.pooled, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
RA.plot_before <- plot3
jpeg(file="plot0.jpeg")
RA.plot_before
dev.off()
print("Seurat object created")
saveRDS(RA.pooled, file = "QC.rds")


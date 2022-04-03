library(dplyr)
library(Seurat)
library(patchwork)

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

#Do be passed in yml.yml
mincells<-0
minfeatures<-0
projectname<-"RA"
pattern<-"^mt-"

#Filtering parameters
nFeature_RNA_min<-2000
nFeature_RNA_max<-5000
nCount_RNA_min<--Inf
nCount_RNA_max<-Inf
percentmt_min<-0
percentmt_max<-10

#Normalization parameters
normalization_method<-"LogNormalize"
scale_factor<-10000
margin<- 1
block_size<-NULL
verbose<-TRUE

#Find Variable Features parameters
selection_method<-"mvp"
loess_span<-0.3
clip_max<-"auto"
verbose<-TRUE

print("reading start ...")
#Read Data
RA.datapooled <- Read10X(data.dir = getwd())
print("reading done")

#raw_counts<-read.table(file=paste0("/Users/nd48/Desktop/seurat/realData/","all_merged.txt"),sep="\t")
#head(raw_counts)
#mydata <- CreateSeuratObject(raw.data = raw_counts, min.cells = 3, min.genes = 200, project = "mydata_scRNAseq")

#Create Seaurat Object
print("Creating Seurat object")
RA.pooled  <- CreateSeuratObject(counts = RA.datapooled, project = projectname, min.cells = mincells)
RA.pooled[["percent.mt"]] <- PercentageFeatureSet(RA.pooled, pattern = pattern)
print("Seurat object created")
#Plot
print("Started plots")
plot1 <- FeatureScatter(RA.pooled, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(RA.pooled, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
RA.plot_before <- plot1 + plot2
print("Finished plots")

#Filtering

#RA.pooled.subset <- subset(RA.pooled, subset = nFeature_RNA > nFeature_RNA_min & nFeature_RNA < nFeature_RNA_max & nCount_RNA > nCount_RNA_min & nCount_RNA < nCount_RNA_max & percent.mt > percentmt_max & percent.mt < percentmt_max)
RA.pooled.subset <- subset(RA.pooled, subset = nFeature_RNA > 500  & percent.mt < 10)
print("Finished Filtering")

#Plot
plot1 <- FeatureScatter(RA.pooled, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(RA.pooled, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
RA.plot_filtering <- plot1 + plot2
#Data Normalization
print("Started Normalization")
RA.pooled.subset <- NormalizeData(RA.pooled.subset, normalization.method = normalization_method, scale.factor = scale_factor, margin = margin, block.size = block_size,verbose = verbose) 
print("Finished Normalization")
#Find Variable Features
RA.pooled.subset <- FindVariableFeatures(RA.pooled.subset, selection.method = "mvp")
#Data Scaling 
RA.pooled.subset <- ScaleData(RA.pooled.subset, vars.to.regress = c("percent.mt","nCount_RNA"))
RA.pooled.subset <- RunPCA(RA.pooled.subset, features = VariableFeatures(object = RA.pooled.subset))
RA.pooled.subset <- FindNeighbors(RA.pooled.subset, dims = 1:32, nn.method="rann") 
RA.pooled.subset <- FindClusters(RA.pooled.subset, resolution = c(0.6))
RA.pooled.subset <- RunUMAP(RA.pooled.subset, dims = 1:32)#, umap.method = "umap-learn", metric = "correlation")
RA.pooled.subset <- RunTSNE(RA.pooled.subset, dims = 1:32)
RA.pooled.subset@misc$markers <- FindAllMarkers(RA.pooled.subset, logfc.threshold = 0.25, min.pct = 0.25, return.thresh = 0.01)

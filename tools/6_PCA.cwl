#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript

hints:
  DockerRequirement:
    dockerPull: fleming/sc-rna-seq:latest
    
inputs:
  script:
    type: File
    inputBinding:
      position: 1
  dataFile:
    type: File
    inputBinding:
      position: 2  
outputs:
  pca_data:
    type: File
    outputBinding:
      glob: PCA.rds
  pca_1_plot:
    type: File
    outputBinding:
      glob: pca_1.jpeg
  pca_2_plot:
    type: File
    outputBinding:
      glob: pca_2.jpeg
  pca_3_plot:
    type: File
    outputBinding:
      glob: pca_3.jpeg
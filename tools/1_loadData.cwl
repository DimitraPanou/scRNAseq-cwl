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
  barcodes:
    type: File
    inputBinding:
      position: 2
  features:
    type: File
    inputBinding:
      position: 3
  matrix:
    type: File
    inputBinding:
      position: 4
  minCells:
    type: int
    inputBinding:
      position: 5
  minFeatures:
    type: int
    inputBinding:
      position: 6
  projectName:
    type: string
    inputBinding:
      position: 7
  pattern:
    type: string
    inputBinding:
      position: 8
  
outputs:
  loaded_data:
    type: File
    outputBinding:
      glob: QC.rds
  plot0:
    type: File
    outputBinding:
      glob: plot0.jpeg

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
  nFeatureRNAmin:
    type: string
    inputBinding:
      position: 3
  nFeatureRNAmax:
    type: string
    inputBinding:
      position: 4
  nCountRNAmin:
    type: string
    inputBinding:
      position: 5
  nCountRNAmax:
    type: string
    inputBinding:
      position: 6
  percentMTmin:
    type: string
    inputBinding:
      position: 7
  percentMTmax:
    type: string
    inputBinding:
      position: 8
  
outputs:
  filtered_data:
    type: File
    outputBinding:
      glob: Filter.rds
  filtered_data_plot:
    type: File
    outputBinding:
      glob: plot1.jpeg


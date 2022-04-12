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
  selection_method:
    type: string
    inputBinding:
      position: 3
  loess_span:
    type: string
    inputBinding:
      position: 4
  clip_max:
    type: string
    inputBinding:
      position: 5
  num_bin:
    type: string
    inputBinding:
      position: 6
  binning_method:
    type: string
    inputBinding:
      position: 7
  
outputs:
  features_data_plot:
    type: File
    outputBinding:
      glob: find_features_data_plot.jpeg
  find_features_data:
    type: File
    outputBinding:
      glob: FeatureSelection.rds
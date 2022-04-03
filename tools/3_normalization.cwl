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
  normalization_method:
    type: string
    inputBinding:
      position: 3
  scale_factor:
    type: string
    inputBinding:
      position: 4
  margin:
    type: string
    inputBinding:
      position: 5
  block_size:
    type: string
    inputBinding:
      position: 6
  verbose:
    type: string
    inputBinding:
      position: 7
  
outputs:
  normalized_data:
    type: File
    outputBinding:
      glob: Normalization.rds
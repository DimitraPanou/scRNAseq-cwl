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
  neighbors_method:
    type: string
    inputBinding:
      position: 3
  k:
    type: string
    inputBinding:
      position: 4
outputs:
  find_neighbors:
    type: File
    outputBinding:
      glob: FindNeighbors.rds
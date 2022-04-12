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
  run_tsne_data:
    type: File
    outputBinding:
      glob: RunTSNE.rds
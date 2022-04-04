#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs:
  loadData:
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
  filterData:
    type: File
    inputBinding:
      position: 9
  nFeatureRNAmin:
    type: string
    inputBinding:
      position: 10
  nFeatureRNAmax:
    type: string
    inputBinding:
      position: 11
  nCountRNAmin:
    type: string
    inputBinding:
      position: 12
  nCountRNAmax:
    type: string
    inputBinding:
      position: 13
  percentMTmin:
    type: string
    inputBinding:
      position: 14
  percentMTmax:
    type: string
    inputBinding:
      position: 15
  normalizeData:
    type: File
    inputBinding:
      position: 16
  normalization_method:
    type: string
    inputBinding:
      position: 17
  scale_factor:
    type: string
    inputBinding:
      position: 18
  margin:
    type: string
    inputBinding:
      position: 19
  block_size:
    type: string
    inputBinding:
      position: 20
  verbose:
    type: string
    inputBinding:
      position: 21

outputs:
  step1Output:
    type: File
    outputSource: loadData/loaded_data
  step11utput:
    type: File
    outputSource: loadData/plot0
  step2Output:
    type: File
    outputSource: filterData/filtered_data
  step22Output:
    type: File
    outputSource: filterData/plots
  step3Output:
    type: File
    outputSource: normalizeData/normalized_data

steps:
  loadData:
    run: ../tools/1_loadData.cwl
    in:
      script: loadData
      barcodes: barcodes
      features: features
      matrix: matrix
      minCells: minCells
      minFeatures: minFeatures
      projectName: projectName
      pattern: pattern
    out: [loaded_data,plot0]
  filterData:
    run: ../tools/2_filter.cwl
    in:
      script: filterData
      dataFile: loadData/loaded_data
      nFeatureRNAmin: nFeatureRNAmin
      nFeatureRNAmax: nFeatureRNAmax
      nCountRNAmin: nCountRNAmin
      nCountRNAmax: nCountRNAmax
      percentMTmin: percentMTmin
      percentMTmax: percentMTmax
    out: [filtered_data,plots]
  normalizeData:
    run: ../tools/3_normalization.cwl
    in:
      script: normalizeData
      dataFile: filterData/filtered_data
      normalization_method: normalization_method
      scale_factor: scale_factor
      margin: margin
      block_size: block_size
      verbose: verbose
    out: [normalized_data]


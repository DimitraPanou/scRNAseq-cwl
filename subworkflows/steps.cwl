#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
inputs:
  running_step:
    type: int
    inputBinding:
      position: 1
  loadDataR:
    type: File
    inputBinding:
      position: 2
  barcodes:
    type: File
    inputBinding:
      position: 3
  features:
    type: File
    inputBinding:
      position: 4
  matrix:
    type: File
    inputBinding:
      position: 5
  minCells:
    type: int
    inputBinding:
      position: 6
  minFeatures:
    type: int
    inputBinding:
      position: 7
  projectName:
    type: string
    inputBinding:
      position: 8
  pattern:
    type: string
    inputBinding:
      position: 9
  filterDataR:
    type: File
    inputBinding:
      position: 10
  nFeatureRNAmin:
    type: string
    inputBinding:
      position: 11
  nFeatureRNAmax:
    type: string
    inputBinding:
      position: 12
  nCountRNAmin:
    type: string
    inputBinding:
      position: 13
  nCountRNAmax:
    type: string
    inputBinding:
      position: 14
  percentMTmin:
    type: string
    inputBinding:
      position: 15
  percentMTmax:
    type: string
    inputBinding:
      position: 16
  normalizeDataR:
    type: File
    inputBinding:
      position: 17
  normalization_method:
    type: string
    inputBinding:
      position: 18
  scale_factor:
    type: string
    inputBinding:
      position: 19
  margin:
    type: string
    inputBinding:
      position: 20
  block_size:
    type: string
    inputBinding:
      position: 21
  verbose:
    type: string
    inputBinding:
      position: 22
  featureSelectionDataR:
    type: File
    inputBinding:
      position: 23
  selection_method:
    type: string
    inputBinding:
      position: 24
  loess_span:
    type: string
    inputBinding:
      position: 25
  clip_max:
    type: string
    inputBinding:
      position: 26 
  num_bin:
    type: string
    inputBinding:
      position: 27
  binning_method:
    type: string
    inputBinding:
      position: 28
  num_features:
    type: string
    inputBinding:
      position: 29
  scaleDataR:
    type: File
    inputBinding:
      position: 30
  runPCAR:
    type: File
    inputBinding:
      position: 31
  findNeighborsR:
    type: File
    inputBinding:
      position: 32
  neighbors_method:
    type: string
    inputBinding:
      position: 33
  k:
    type: string
    inputBinding:
      position: 34
  clusterDataR:
    type: File
    inputBinding:
      position: 35
  runUmapR:
    type: File
    inputBinding:
      position: 36
  runTSNER:
    type: File
    inputBinding:
      position: 37
  find_markersR:
    type: File
    inputBinding:
      position: 38

outputs:
  loadDataOutput:
    type: File
    outputSource: loadData/loaded_data
  loadDataPlot:
    type: File
    outputSource: loadData/data_plot
  filterDataOutput:
    type: File
    outputSource: filterData/filtered_data
  filterDataPlot:
    type: File
    outputSource: filterData/filtered_data_plot
  normalizeDataOutput:
    type: File
    outputSource: normalizeData/normalized_data
  findFeaturesOutput:
    type: File
    outputSource: findFeatures/find_features_data
  findFeaturesPlot:
    type: File
    outputSource: findFeatures/features_data_plot
  scaleDataOutput:
    type: File
    outputSource: scaleData/scaling_data
  runPCAOutput:
    type: File
    outputSource: runPCA/pca_data
  runPCAPlot1:
    type: File
    outputSource: runPCA/pca_1_plot
  runPCAPlot2:
    type: File
    outputSource: runPCA/pca_2_plot
  runPCAPlot3:
    type: File
    outputSource: runPCA/pca_3_plot
  findNeighborsOutput:
    type: File
    outputSource: findNeighbors/find_neighbors
  clusterDataOutput:
    type: File
    outputSource: clusterData/cluster_data
  runUMAPOutput:
    type: File
    outputSource: runUMAP/run_umap_data
  runUMAPOutputPlot:
    type: File
    outputSource: runUMAP/run_umap_data_plot
  runTSNEOutput:
    type: File
    outputSource: runTSNE/run_tsne_data
  findMarkersOutput:
    type: File
    outputSource: findAllMarkers/find_markers
steps:
  loadData:
    in:
      script: loadDataR
      barcodes: barcodes
      features: features
      matrix: matrix
      minCells: minCells
      minFeatures: minFeatures
      projectName: projectName
      pattern: pattern
    run: tools/1_loadData.cwl
    out: [loaded_data,data_plot]
  filterData:
    run: tools/2_filter.cwl
    in:
      script: filterDataR
      dataFile: loadData/loaded_data
      nFeatureRNAmin: nFeatureRNAmin
      nFeatureRNAmax: nFeatureRNAmax
      nCountRNAmin: nCountRNAmin
      nCountRNAmax: nCountRNAmax
      percentMTmin: percentMTmin
      percentMTmax: percentMTmax
    out: [filtered_data,filtered_data_plot]
  normalizeData:
    run: tools/3_normalization.cwl
    in:
      script: normalizeDataR
      dataFile: filterData/filtered_data
      normalization_method: normalization_method
      scale_factor: scale_factor
      margin: margin
      block_size: block_size
      verbose: verbose
    out: [normalized_data]
  findFeatures:
    run: tools/4_featureSelection.cwl
    in:
      script: featureSelectionDataR
      dataFile: normalizeData/normalized_data
      selection_method: selection_method
      loess_span: loess_span
      clip_max: clip_max
      num_bin: num_bin
      binning_method: binning_method
      nfeatures: num_features
    out: [find_features_data,features_data_plot]
  scaleData:
    run: tools/5_Scaling.cwl
    in:
      script: scaleDataR
      dataFile: findFeatures/find_features_data
    out: [scaling_data]
  runPCA:
    run: tools/6_PCA.cwl
    in:
      script: runPCAR
      dataFile: scaleData/scaling_data
    out: [pca_data, pca_1_plot, pca_2_plot, pca_3_plot]
  findNeighbors:
    run: tools/7_findNeighbors.cwl
    in:
      script: findNeighborsR
      dataFile: runPCA/pca_data
      neighbors_method: neighbors_method
      k: k
    out: [find_neighbors]
  clusterData:
    run: tools/8_clusterData.cwl
    in:
      script: clusterDataR
      dataFile: findNeighbors/find_neighbors
    out: [cluster_data]
  runUMAP:
    run: tools/9_runUMAP.cwl
    in:
      script: runUmapR
      dataFile: findNeighbors/find_neighbors
    out: [run_umap_data, run_umap_data_plot]
  runTSNE:
    run: tools/10_runTSNE.cwl
    in:
      script: runTSNER
      dataFile: runUMAP/run_umap_data
    out: [run_tsne_data]

  findAllMarkers:
    run: tools/11_findMarkers.cwl
    in:
      script: find_markersR
      dataFile: runTSNE/run_tsne_data
    out: [find_markers]
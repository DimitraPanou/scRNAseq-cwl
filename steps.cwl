#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
inputs:
  loadDataR:
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
  filterDataR:
    type: File
    inputBinding:
      position: 5
  normalizeDataR:
    type: File
    inputBinding:
      position: 6
  featureSelectionDataR:
    type: File
    inputBinding:
      position: 7
  scaleDataR:
    type: File
    inputBinding:
      position: 8
  runPCAR:
    type: File
    inputBinding:
      position: 9
  findNeighborsR:
    type: File
    inputBinding:
      position: 10
  clusterDataR:
    type: File
    inputBinding:
      position: 11
  runUmapR:
    type: File
    inputBinding:
      position: 12
  runTSNER:
    type: File
    inputBinding:
      position: 13
  find_markersR:
    type: File
    inputBinding:
      position: 314

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
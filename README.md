# RNASeq-ML-SAKI-Analysis

This repository contains a comprehensive pipeline for RNA-sequencing data analysis and machine learning model development, focusing on identifying differentially expressed genes (DEGs) in septic acute kidney injury (SAKI) patients. The project utilizes R and Python for data processing, visualization, and predictive modeling.

Repository Structure
1. DataSet
This folder contains the RNA-seq datasets used for analysis:

GSE57065_RAW.tar: Raw RNA-seq data archive.
GSE94717_RAW.tar: Additional raw RNA-seq data archive.
GSE232404_processed_data_file.xlsx: Processed data file for gene expression analysis.
GSE242059_processed_data_file.xlsx: Another processed data file for analysis.
2. Code_files
This folder contains the scripts and Jupyter notebooks used in the project:

.CEL_file_processing.R: R script for processing CEL files.
.GPR_file_processing.R: R script for processing GPR files.
EDA_Analysis.ipynb: Jupyter notebook for exploratory data analysis (EDA) of RNA-seq data.
Logistic_Regression.ipynb: Jupyter notebook for building and evaluating a Logistic Regression model.
Random_Forest.ipynb: Jupyter notebook for building and evaluating a Random Forest model.
SVM.ipynb: Jupyter notebook for building and evaluating a Support Vector Machine model.
Key Features
Data Processing: Includes scripts for handling raw RNA-seq data files and generating processed datasets.
Exploratory Data Analysis (EDA): Insights into the datasets, including visualization and statistical summaries.
Machine Learning: Implementation of Logistic Regression, Random Forest, and SVM models to predict gene expression patterns.
Gene Enrichment Analysis: Visualization and interpretation of biological pathways and processes using DEGs.

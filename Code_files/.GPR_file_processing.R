# Step 1: Install and Load Required Libraries
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("limma", force = TRUE)
install.packages("writexl")

library(limma)       # For processing .gpr files
library(writexl)     # For exporting data to .xlsx

# Step 2: Set the Directory Containing .gpr Files
setwd("C:\\Users\\shaje\\Desktop\\New folder\\New folder (3)")# Replace with the directory where your .gpr files are located

# Step 3: List All .gpr Files in the Directory
gpr_files <- list.files(pattern = "\\.gpr$")
if (length(gpr_files) == 0) stop("No .gpr files found in the directory!")

# Step 4: Read All .gpr Files
data_list <- lapply(gpr_files, function(file) {
  cat("Processing file:", file, "\n")
  read.maimages(file, source = "genepix", columns = list(R = "F635 Median", G = "F532 Median", 
                                                         Rb = "B635 Median", Gb = "B532 Median"))
})

# Step 5: Quality Control
# Remove spots flagged as unreliable
data_list <- lapply(data_list, function(data) {
  data$R[data$weights == 0] <- NA
  data$G[data$weights == 0] <- NA
  data
})

# Step 6: Background Correction
# Subtract background intensities
data_list <- lapply(data_list, function(data) {
  data$R <- data$R - data$Rb
  data$G <- data$G - data$Gb
  data
})

# Step 7: Combine Data
# Extract the Red channel (or Green, depending on your analysis)
combined_data <- do.call(cbind, lapply(data_list, function(data) data$R))

# Step 8: Normalize the Data
# Apply cyclic Lowess normalization
normalized_data <- normalizeBetweenArrays(combined_data, method = "cyclicloess")

# Step 9: Add Metadata
# Include gene identifiers or spot metadata if available
gene_ids <- data_list[[1]]$genes$Name  # Replace 'Name' with the appropriate column in your .gpr file
if (is.null(gene_ids)) gene_ids <- paste0("Gene_", seq_len(nrow(normalized_data))) # Fallback if no gene IDs

# Create a data frame for the final output
final_output <- data.frame(
  GeneID = gene_ids,
  normalized_data
)

# Step 10: Export Processed Data
output_file <- "C:\\Users\\shaje\\Desktop\\New folder\\New folder (3)\\processed_gpr_data.xlsx"  # Correct the save path
write_xlsx(final_output, output_file)
cat("Processed data saved to:", output_file, "\n")

# Step 11: Optional - Diagnostic Plots
# Boxplots to visualize normalization effect
boxplot(as.matrix(combined_data), main = "Before Normalization", las = 2)
boxplot(as.matrix(normalized_data), main = "After Normalization", las = 2)

# Generate an MA plot for the first file as an example
plotMA(data_list[[1]], main = "MA Plot Example")

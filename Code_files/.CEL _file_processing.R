# Step 1: Install and Load Required Libraries
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(c("affy", "oligo", "writexl"), force = TRUE)


library(affy)        # For handling Affymetrix data
library(oligo)       # For preprocessing .CEL files
library(writexl)     # For exporting processed data

# Step 2: Set the Working Directory
setwd("C:\\Users\\shaje\\Desktop\\New folder\\New folder (2)")  # Replace <path_to_CEL_files> with the directory containing your .CEL files

# Step 3: List and Read .CEL Files
cel_files <- list.files(pattern = "\\.CEL$", ignore.case = TRUE)
if (length(cel_files) == 0) stop("No .CEL files found in the specified directory!")

getwd()  # This will display the current working directory

# Step 4: Load the .CEL Files
data <- read.celfiles(cel_files)

# Step 5: Quality Control
# Perform basic quality checks on the raw data
boxplot(data, main = "Raw Data Boxplot")  # Visualize intensity distribution
image(data[, 1])  # Visualize the spatial distribution for the first array

# Step 6: Background Correction and Normalization
# Normalize using the Robust Multi-array Average (RMA) method
normalized_data <- rma(data)

# Step 7: Extract Expression Matrix
expr_matrix <- exprs(normalized_data)

# Step 8: Add Gene Annotation
# Add annotation information (if available)
annot <- fData(normalized_data)  # Probe-level annotations
final_data <- cbind(annot, expr_matrix)

# Step 9: Export Processed Data
output_file <- "C:/Users/shaje/Desktop/New folder/New folder (2)/processed_cel_data.xlsx"  # Specify the save path
write_xlsx(as.data.frame(final_data), output_file)

cat("Processed data saved to:", output_file, "\n")

# Step 10: Diagnostic Plots (Optional)
# Boxplot to visualize normalized data
boxplot(expr_matrix, main = "Normalized Data Boxplot", las = 2)

# Principal Component Analysis (PCA) to visualize sample clustering
pca <- prcomp(t(expr_matrix))
plot(pca$x[, 1:2], col = 1:length(cel_files), pch = 19, main = "PCA Plot")
legend("topright", legend = cel_files, col = 1:length(cel_files), pch = 19)

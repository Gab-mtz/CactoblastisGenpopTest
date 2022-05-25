# This script will help you run an association analysis using lea
# You must have the R lea package installed and the lfmm file in the same directory

# Charge the library
library(LEA)

# Charge the vcf file to convert it to lfmm format
output = vcf2lfmm("Yourfile.vcf")

# Obtain the output "plop.lfmm"
output = vcf2lfmm("Yourfile.vcf", "plop.lfmm")

# Conversion to get the .lfmm file
output = vcf2lfmm("Yourfile.vcf", force = FALSE)

# Step 1: Make an PCA
pc = pca("Yourfile.lfmm", scale = TRUE)
# Now you have the project *.pcaProject
# Number of significant components using tract.widom()
tw = tracy.widom(pc)
# See pvalues
tw$pvalues[1:8]
# Make a plot with the percentage of variance explained by each component
plot(tw$percentage)

# Step 2: Ancestral populations and their entropy value
# Create a project
project = NULL
# Run the model
project = snmf("Yourfile.geno", K = 1:9, entropy = TRUE, repetitions = 10, project = "new")
# Make a plot
plot(project, col = "#2a9d8f", pch = 19, cex = 1.5)
# Graphic of genetic groups
project = load.snmfProject("Yourfile.snmfProject")
best = which.min(cross.entropy(project, K = 4))
my.colors <- c("#6a4c93", "#5f0f40", "#f28482", "# b5838d")
barchart(project, K = 4, run = best, border = NA, space = 0, col = my.colors, xlab = "Individuals", ylab = "Ancestry proportions", main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order), labels = bp$order, las=1, cex.axis = .4)
 
# Step 3: Impute the missing genotypes
impute(project, "Yourfile.lfmm", method = "mode", K = 5, run = best) # K is the number of your original populations, now you have the *_imputed.lfmm file.

# Step 4: Population differentiation tests
# Charge the snmf project
p = snmf.pvalues(project, entropy = TRUE, ploidy = 2, K = 5)
# Obtain an object with p values and plot it
pvalues = p$pvalues
par(mfrow = c(2,1))
hist(pvalues, col = "#f28482")
plot(-log10(pvalues), pch = 19, col = "#5f0f40", cex = .5)

# Step 5: Create a file with the environmental variables
A = read.table("Example") # Example is created since the terminal and contains the enviromental information, one line for each individual and one column for each variable.
# Example for thre individuals and two variables:
25.1	565.1
25.3	567.2
25.5	627.3
# Read the object
> A
    V1    V2
1 25.1 565.1
2 25.3 567.2
3 25.5 627.3
> write.env(A, "Example.env") # The file *.env is the input for the analysis

# Step 6: Association analysis
project = NULL
project = lfmm("Caribe_clean_plink.recode.lfmm", "Vars.env", K = 7, repetitions = 3, project = "new")

# Step 7: Compute adjusted p-values 

p = lfmm.pvalues(project, K = 7) See yours latent factors to decide K
pvalues = p$values

# Step 8: Adjust p-values for multiple testing issues using the BH procedure ######

for (alpha in c(.05,.1,.15,.2)) print(paste("Expected FDR:", alpha))








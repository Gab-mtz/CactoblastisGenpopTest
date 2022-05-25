# This script will help you to visualize significant snps presumably associated with environmental variables.
# You must have the R "LEA" and "qvalue" packages installed

# Charge the librarys and the *.lfmm project obtained in the association analysis
library(LEA)
library(qvalue)
project = load.lfmmProject("Yourfile.lfmmProject")

# The number of steps depends on the number of variables you have used, you can change the treshold 0.2] 
# Step 1: Variable 1
p.values.lfmm.v1 <-lfmm.pvalues(project,K= ,d=1) # "d" refers to the number of variable
Variable1.mod.K.d1   <- qvalue(p.values.lfmm.v1$pvalues)
Outliers.v1 <-Variable1.mod.K.d1$qvalues[Variable1.mod.K.d1$qvalues<0.2] 
# Step 2: Variable 2
p.values.lfmm.v2 <-lfmm.pvalues(project,K=,d=2)
Variable2.mod.K.d2  <- qvalue(p.values.lfmm.v2$pvalues)
Outliers.v2 <-Variable2.mod.K.d2$qvalues[Variable2.mod.K.d2$qvalues<0.2]

# See the qvalues
Variable1.mod.K.d1
Variable2.mod.K.d2

# Plot
plot(1:X,-log10(Variable1.mod.K.d1)) # X is the original number of snps # All pvalues of the variable 1
plot(1:X,-log10(Variable2.mod.K.d2)) # All pvalues of the variable 2

# Make a table with all the informarmation
Outliers.ALL.qvalues <-data.frame(qvalue.d1=Variable1.mod.K.d1$qvalues,qvalue.d2=Variable2.mod.K.d2$qvalues,Index=1:X)

# Add the treshold
Outliers.ALL.qvalues[Outliers.ALL.qvalues$qvalue.d2<0.2,]
Outliers.v1.qvalues <-Outliers.ALL.qvalues[Outliers.ALL.qvalues$qvalue.d2<0.2,] # Significant snps asociated with variable 1.
Outliers.v2.qvalues <-Outliers.ALL.qvalues[Outliers.ALL.qvalues$qvalue.d2<0.2,] # Significant snps asociated with variable 2.

# Plot the candidates snps for variable 1
plot(Outliers.ALL.qvalues$Index,-log10(Outliers.ALL.qvalues$qvalue.d1),pch=20,col="gray")
points(Outliers.d1.qvalues$Index,-log10(Outliers.d1.qvalues$qvalue.d1),col="#2a9d8f",pch=19)

# Plot the candidates snps for variable 2
plot(Outliers.ALL.qvalues$Index,-log10(Outliers.ALL.qvalues$qvalue.d2),pch=20,col="gray")
points(Outliers.d2.qvalues$Index,-log10(Outliers.d2.qvalues$qvalue.d2),col="#264653",pch=19)


# This script contains the instructions to perform an association analysis with environmental variables using Baypass.
# You must have the program, the g_baypass executable, the input file and the environmental information file installed and compiled in the same working directory

# Step 1: Run baypass. At the end of this step you will get the array "covis_mat_omega.out" which will be the input of the next step.
echo "Starts at:"
date

./g_baypass -npop 7 -gfile SN_baypass.input -efile env_file.txt -outprefix covis -nval 1000 -thin 25 -burnin 500 -npilot 10 -pilotlength 500; done 
echo "Ends at:"

# Step 2: Association analysis using the AUX model.
echo "Starts at:"
date

./g_baypass -npop 7 -gfile SN_baypass.input -omegafile covis_mat_omega.out -efile env_file.txt -outprefix SN_covaux  -nval 1000 -thin 25 -burnin 500 -npilot 10 -pilotlength 500 -auxmodel -nthreads 1; done 
echo "Ends at:"

# Enter R and load the following packages and the file “baypass_utils.R”
 R
library(corrplot)
library(ape)
source("baypass_utils.R")

# Step 4: Plot the correlation matrix based on the generated covariance matrix.
 omega<-as.matrix(read.table("covis_mat_omega.out"))

# Step 5: Define the name/key of the populations.
pop.names<-c("pop1","pop2","pop3","pop4","pop5","pop6","pop8")

# Step 6: Add the population definition to the omega object.
dimnames(omega)<-list(pop.names,pop.names)

# Step 7: View the correlation matrix and save the graph.
cor.mat=cov2cor(omega)
corrplot(cor.mat,type="upper",method="color",mar=c(2,1,2,2)+0.1,main=expression("Correlation map based on"~hat(Omega)))
dev.off()


# Step 8: Obtain and graph the candidate SNP`s.
aux.snp.xtx=read.table("SN_covaux_summary_pi_xtx.out",h=T)$M_XtX

# Step 9: Generate the simulations to calibrate the statistic and obtain the threshold. For this, the real data and the obtained parameters are loaded.

pi.beta.coef<-read.table("SN_covaux_summary_beta_params.out",h=T)$Mean
SN.data<-geno2YN("SN_baypass.input")

# Create simulations -----------------------
simu.bta<-simulate.baypass(omega.mat=omega,nsnp=1571,sample.size=SN.data$NN, beta.pi=pi.beta.coef,pi.maf=0.05,remove.fixed.loci=TRUE,suffix="btapods")

# With the above, several *.btapods files will be generated
# Step 10: Exit R. In the console analyze the simulations with the same parameters.
./g_baypass -npop 7 -gfile G.btapods -outprefix anapod -nval 1000 -thin 25 -burnin 500 -npilot 10 -pilotlength 500 -nthreads 1 -seed 85934

# Step 11: Go into R and load the simulated data.
pod.xtx <- read.table("anapod_summary_pi_xtx.out",h=T)$M_XtX
pod.thresh=quantile(pod.xtx,probs=0.95)

# Step 12: Add the threshold to the graph.
plot(aux.snp.xtx,xlab="SNP",ylab="XtX corrected for SMS",cex=1)
abline(h=pod.thresh,lty=2,lwd=1.2,col="red")

# Step 13: Save the plot
dev.off()



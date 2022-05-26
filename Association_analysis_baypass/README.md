# This directory contains a script ("baypass.sh)that will help you perform association analysis using Baypass2.1.
# You must have the program installed and compiled, the executable g_baypass, a file with the environmental information and another file with the snp in baypass format.
# Instructions for compiling the program: 
# Download the program.
# Download the file in .sh format from the page https://gfortran.meteodat.ch/download/x86_64/ and put it in the same directory where the program was downloaded.
# Execute "make clean all FC=gfortran" in the same working directory of the program.
# You will get an executable ("g_baypass") with which the program runs.
# The snps input file contains the information of each locus per population with the number of times it appears in each population.
# The environmental information file contains a row with the mean of each environmental variable and a column per population.


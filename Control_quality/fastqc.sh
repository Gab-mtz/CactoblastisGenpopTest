#!/bin/bash

# This script can be used for analyze the quality of a data set. We recommend performing this analysis before and after applying the quality filters.
# The software FastQC and the file for analyze must be in the same working directory.
# After this analysis you will obtain and html file in which you can visualize the results. Also, you will obtain a .zip file with all the graphics of the results.
echo "Comienza a las:"
date

fastqc Plate3_R2_PAIRED.fastq.gz
echo "Finaliza a las:"
date
done


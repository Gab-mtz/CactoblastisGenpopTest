#!/bin/bash

echo "Starts at:" # This line is useful to indicate when the program starts
date

ipyrad -p params_demultiplex.txt -s 1234567  # The option -s 1234567 indicates that the program will run all steps
echo "Ends at:"  # This line helps you to note when the program ends
date



#!/bin/bash

echo "Starts at:" # This line helps you to know when the demultiplexing analysis start
date

ipyrad -p params_demultiplex.txt -s 12 # The option -s 12 indicates that the program will run up to the step two only
echo "Ends at:" # This line helps to indicate the date in which the program end
date



#!/bin/bash

echo "Starts at:"
date

ipyrad -p params_demultiplex.txt -s 12
echo "Ends at:"
date



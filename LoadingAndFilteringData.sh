!/bin/sh

clear

# Set local path variable
scriptpath=$(pwd -P)

echo "$scriptpath"

# Run Rscript with local path argument
Rscript LoadingAndFilteringData.R $scriptpath

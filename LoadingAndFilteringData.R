################################################################################
# Loading and filtering data from biodiversity dataset
#
# Carlos Kassab
# 2025-April-22
################################################################################

libsNeeded <- c("arrow", "tidyverse", "classInt", "duckdb")

installed_libs <- libsNeeded %in% rownames(installed.packages())
if (any(installed_libs == FALSE)) {
  print("Install the following libraries and run the program again:")
  print(libsNeeded[!installed_libs])
  stop()
}


# import libraries
library(arrow)
library(tidyverse)
library(duckdb)

args <- commandArgs( trailingOnly = TRUE ) # read arguments

if( length(args) > 0 ){
  setwd( args[1] ) # Set working directory as the actual directory path from args passed by the shel/batch file.
} else {
  # Set working directory path in when running it from R or Rstudio.
  # ex: setwd("/tmp/BiodiversityWithShiny")
}


# Loading Data.
tryCatch(
  expr = {
    bioDiversityData <- open_csv_dataset(
      sources = "Data/occurence.csv",
      schema=(schema(id = string()
                   , occurrenceID = string()
                   , catalogNumber = string()
                   , basisOfRecord = string()
                   , collectionCode = string()
                   , scientificName = string()
                   , taxonRank = string()
                   , kingdom = string()
                   , family = string()
                   , higherClassification = string()
                   , vernacularName = string()
                   , previousIdentifications = string()
                   , individualCount = int64()
                   , lifeStage = string()
                   , sex = string()
                   , longitudeDecimal = float32()
                   , latitudeDecimal = float32()
                   , geodeticDatum = string()
                   , dataGeneralizations = string()
                   , coordinateUncertaintyInMeters = int64()
                   , continent = string()
                   , country = string(), countryCode = string()
                   , stateProvince = string()
                   , locality = string()
                   , habitat = string()
                   , recordedBy = string()
                   , eventID = string()
                   , eventDate = date32()
                   , eventTime = time32()
                   , samplingProtocol = string()
                   , behavior = string()
                   , associatedTaxa = string()
                   , references = string()
                   , rightsHolder = string()
                   , license = string()
                   , modified = string())),
      skip = 1 )
    
    print(Sys.time())
    print("Filtering Data.")
    
    # Remove duckdb database file
    file.remove("Data/bioDiversityData.duckdb")
    
    # Connect to DuckDB
    con <- dbConnect(duckdb::duckdb(), "Data/bioDiversityData.duckdb")
    
    # Register the Arrow dataset as a DuckDB view
    duckdb_register_arrow(con, "arrow_bioDiversityData", bioDiversityData)    

    # Copy the filtered data to a DuckDB table
    dbExecute(con, "CREATE TABLE bioDiversityByCountry AS SELECT id, country, longitudeDecimal, latitudeDecimal, vernacularName, scientificName FROM arrow_bioDiversityData")# WHERE countryCode = 'PL'")

    print(Sys.time())
    
  },
  error = function(ex){
    print(paste("There was an error while reading, filtering and writing data.", ex))
  },    
  finally = {
    dbDisconnect( con )
    gc()
    rm(list=ls()) # Clean memory
  }
)

# On the personal computer, clear the cache generated from reading the file. 
# On Linux, you can run: ===>>> sudo sh -c 'echo 1 > /proc/sys/vm/drop_caches'


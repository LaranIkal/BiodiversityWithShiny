#*******************************************************************************
#* app.R
#* Dashboard Main controller.
#* Used to import Shiny ui and server components; initializes the app.
#* if error found send email to laran.ikal@gmail.com
#* Carlos Kassab
#* 2025-April-26
#*******************************************************************************


libsNeeded <- c("shiny", "shinydashboard", "tidyverse",
                "sf", "duckdb", "rnaturalearth", "ggplot2")

installed_libs <- libsNeeded %in% rownames(installed.packages())
if (any(installed_libs == FALSE)) {
  print("Install the following libraries and run the program again:")
  print(libsNeeded[!installed_libs])
  stop()
}


args <- commandArgs( trailingOnly = TRUE ) # read arguments

if( length(args) > 0 ){
  setwd( args[1] ) # Set working directory as the actual directory path from args passed by the shel/batch file.
} else {
  # Set working directory path in when running it from R or Rstudio.
  # ex: setwd("/tmp/BiodiversityWithShiny")
}

# Libraries are loaded in different programs.
library( shiny )
library( shinydashboard )

source( "ui.R" )
source( "server.R" )

shinyApp( ui, server )


#*******************************************************************************
#* server.R
#* Server Shiny file to develop al the logic needed for the dashboard.
#* if error found send an email to laran.ikal@gmail.com
#* Carlos Kassab
#* 2025-April-30
#*******************************************************************************

library(tidyverse)
library(sf)
library(rnaturalearth)
library(duckdb)
library(ggplot2)

countriesAndStates <- ne_states( returnclass = "sf")
countriyList <- countries <- sort(unique(countriesAndStates$admin))

countryData <- function(countryName) { countriesAndStates %>% filter( admin == countryName ) }



server <- function( input, output, session ) {
  
  output$Box1 <- renderUI(selectInput("country","select a country", countriyList,"Poland", selectize=TRUE))
  
  output$Box2 <- renderUI(
    if (is.null(input$country) || is.na(input$country)) { 
      return() 
    } else {    
      con <- dbConnect(duckdb::duckdb(), "../Data/bioDiversityData.duckdb")
      bioDiversityData <- dbGetQuery( con, paste0("SELECT * FROM bioDiversityByCountry WHERE country = '", input$country,"'"))
      dbDisconnect( con )
      selectInput("vernacularName","select vernacular name", sort(unique(bioDiversityData$vernacularName)), selectize=TRUE)
    }
  )

  output$Box3 <- renderUI(
    if (is.null(input$country) || is.na(input$country)) { 
      return() 
    } else {    
      con <- dbConnect(duckdb::duckdb(), "../Data/bioDiversityData.duckdb")
      bioDiversityData <- dbGetQuery( con, paste0("SELECT * FROM bioDiversityByCountry WHERE country = '", input$country,"'"))
      dbDisconnect( con )
      selectInput("scientificName","select sicentific name", sort(unique(bioDiversityData$scientificName)), selectize=TRUE)
    }
  )
  
  observeEvent(input$vernacularName, {

   # countryData <- countriesAndStates %>% filter( admin == input$country )
    
    #countryData <- countryData( input$country )
    
    con <- dbConnect(duckdb::duckdb(), "../Data/bioDiversityData.duckdb")
    bioDiversityData <- dbGetQuery( con, paste0("SELECT * FROM bioDiversityByCountry WHERE country = '", input$country,"' AND vernacularName ='", input$vernacularName, "'"))
    dbDisconnect( con )
    my_sf <- st_as_sf(bioDiversityData, coords = c('longitudeDecimal', 'latitudeDecimal'), crs = 4326)
    
    bioDiversityMap <- ggplot(data = countryData( input$country ) ) +
    geom_sf(fill = "lightgreen") +
    geom_sf(data = my_sf, color = "grey", size = 4, shape = 21, fill = "#0066ff") +
    geom_text(data = countryData( input$country ), aes(x = longitude, y = latitude, label = name), 
              size = 3.9, col = "black", fontface = "bold") +
    coord_sf( expand = TRUE)
  
  output$mapPlot <- renderPlot(bioDiversityMap)
  })
  
  
  observeEvent(input$scientificName, {
    
    #countryData <- countriesAndStates %>% filter( admin == input$country )
    
    con <- dbConnect(duckdb::duckdb(), "../Data/bioDiversityData.duckdb")
    bioDiversityData <- dbGetQuery( con, paste0("SELECT * FROM bioDiversityByCountry WHERE country = '", input$country,"' AND scientificName ='", input$scientificName, "'"))
    dbDisconnect( con )
    my_sf <- st_as_sf(bioDiversityData, coords = c('longitudeDecimal', 'latitudeDecimal'), crs = 4326)
    
    bioDiversityMap <- ggplot(data = countryData( input$country ) ) +
      geom_sf(fill = "lightgreen") +
      geom_sf(data = my_sf, color = "grey", size = 4, shape = 21, fill = "#0066ff") +
      geom_text(data = countryData( input$country ), aes(x = longitude, y = latitude, label = name), 
                size = 3.9, col = "black", fontface = "bold") +
      coord_sf( expand = TRUE)
    
    output$mapPlot <- renderPlot(bioDiversityMap)
  })  
}

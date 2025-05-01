#*******************************************************************************
#* body.R
#* Create the body for the ui.
#* If you had multiple tabs, you could split those into their own
#* components as well.
#* if error found send an email to developers.
#* Carlos Kassab
#* 2019-February-06
#*******************************************************************************

body = dashboardBody(
  
  tabItems(
    ########################
    # Second tab content
    ########################
  tabItem(
      tabName = "biodiversity",
      fluidRow(
        
          title = "Select country below:",
          uiOutput("Box1"),
          uiOutput("Box2"),
          uiOutput("Box3"),
        # PLOT THE MAP
        box( width = 12,
             title = "Biodiversity Map", 
             status = "primary", 
             solidHeader = TRUE,              
             plotOutput("mapPlot", 
                        height = "80vh", width = "100%") )
      )
    )
  )
)


#*******************************************************************************
#* ui.R
#* ui Shiny file to develop al the front-end options needed for the dashboard.
#* Here it is divided by components and, it is loading header, sidebar, and body
#* components from separate files.
#* if error found send an email to developers.
#* Carlos Kassab
#* 2019-February-06
#*******************************************************************************

# If shinydashboard library is not imported here, the dashboard does not work 
# on Shiny Server.

library( shiny )
library( shinydashboard )

source( './components/header.R' )
source( './components/sidebar.R' )
source( './components/body.R' )


ui = dashboardPage(
  skin = "green"
  , header = header
  , sidebar =  sidebar
  , body = body )

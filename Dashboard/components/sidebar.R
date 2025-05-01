#*******************************************************************************
#* sidebar.R
#* Create the sidebar menu options for the ui.
#* if error found send an email to developers.
#* Carlos Kassab
#* 2019-February-06
#*******************************************************************************

sidebar = dashboardSidebar( collapsed = TRUE,
  sidebarMenu(
    menuItem( "Biodiversity", tabName = "biodiversity", icon = icon("dashboard"))
  )
)

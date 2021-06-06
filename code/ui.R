########################################
# DnD Spellbook                        #
# by Q.Jacquemin, A.Lanvin & R.Davies  #
# ui.R file                            #
########################################

library(leaflet)
library(shinydashboard)
library(collapsibleTree)
library(shinycssloaders)
library(DT)
library(tigris)

###########
# LOAD UI #
###########

shinyUI(fluidPage(
  
  # load custom stylesheet
  includeCSS("www/style.css"),
  
  # remove shiny "red" warning messages on GUI
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),
  # load page layout
  dashboardPage(
    
    skin = "red",
      
    dashboardHeader(title="DnD SpellBook", titleWidth = 300),
    
    dashboardSidebar(width = 300,
      sidebarMenu(
        HTML(paste0(
          "<br>",
          "<a href='https://openclipart.org/download/224584/FightingSkeleton.svg' target='_blank'><img style = 'display: block; margin-left: auto; margin-right: auto;' src='FightingSkeleton.svg' width = '186'></a>",
          "<br>"
        )),
        menuItem("Home", tabName = "home", icon = icon("home")),
        menuItem("Spell Tree", tabName = "tree", icon = icon("tree")),
        menuItem("Spell Comparator", tabName = "comparator", icon = icon("glasses")),
        menuItem("Spell extractor", tabName = "extractor", icon = icon("database")),
        HTML(paste0(
          "<script>",
            "var today = new Date();",
            "var yyyy = today.getFullYear();",
          "</script>",
          "<br/>",
          "<p style = 'text-align: center;'><small>&copy; - <a href='https://dnd.wizards.com/' target='_blank'>https://dnd.wizards.com/</a> - <script>document.write(yyyy);</script></small></p>")
        ))
      ), # end dashboardSidebar
    
    dashboardBody(
      
      tabItems(
        
        tabItem(tabName = "home",
          
          # home section
          includeMarkdown("www/home.md")
          
        ),
        
        tabItem(tabName = "tree", 
                
          # collapsible spell tree section
          includeMarkdown("www/tree.md"),
          column(3, uiOutput("SelectClass")),
          collapsibleTreeOutput('tree', height='700px') %>% withSpinner(color = "red")
                
        ),
        
        tabItem(
          # spell data comparator
          tabName = "comparator"
        ),
        
        tabItem(
          # spell data extractor
          tabName = "extractor", dataTableOutput("spellsDataTable") %>% withSpinner(color = "red")
          
        )
        
       
              
      )
    
    ) # end dashboardBody
  
  )# end dashboardPage

))